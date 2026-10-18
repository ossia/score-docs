(() => {
  'use strict';

  const videos = document.querySelectorAll('.release-content video');
  if (!videos.length || !('IntersectionObserver' in window)) return;

  const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
  const players = new Map();

  videos.forEach((video, index) => {
    const animated = video.hasAttribute('data-release-loop');
    const player = { visible: false, userPaused: false, requested: false };
    let button;

    const updateButton = () => {
      if (!button) return;
      button.textContent = video.paused ? 'Play' : 'Pause';
      button.setAttribute('aria-label', video.paused ? 'Play animation' : 'Pause animation');
    };

    player.update = () => {
      if (!player.visible || document.hidden) {
        video.pause();
      } else if (animated) {
        // Load a still frame even when reduced motion disables automatic playback.
        video.preload = 'metadata';
        if (!player.userPaused && (!reducedMotion.matches || player.requested)) {
          if (video.paused) video.play().catch(updateButton);
        } else {
          video.pause();
        }
      }
    };

    if (animated) {
      const wrapper = document.createElement('span');
      wrapper.className = 'release-animation';
      button = document.createElement('button');
      button.type = 'button';
      video.id = `release-animation-${index}`;
      button.setAttribute('aria-controls', video.id);
      video.before(wrapper);
      wrapper.append(video, button);
      video.muted = true;
      video.defaultMuted = true;
      video.loop = true;
      video.playsInline = true;
      video.controls = false;
      button.addEventListener('click', () => {
        player.userPaused = !video.paused;
        player.requested = video.paused;
        player.update();
      });
      video.addEventListener('play', updateButton);
      video.addEventListener('pause', updateButton);
      updateButton();
    }
    players.set(video, player);
  });

  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      const player = players.get(entry.target);
      player.visible = entry.isIntersecting && entry.intersectionRatio > 0;
      player.update();
    });
  });
  players.forEach((player, video) => observer.observe(video));

  document.addEventListener('visibilitychange', () => {
    players.forEach(player => player.update());
  });
  reducedMotion.addEventListener('change', () => {
    players.forEach(player => {
      // A newly enabled motion preference takes precedence over earlier playback.
      player.requested = false;
      player.update();
    });
  });
})();
