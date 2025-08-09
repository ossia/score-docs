---
layout: default

title: HTTP device
description: "Web API and HTTP service communication"

parent: Devices
grand_parent: Reference

permalink: /devices/http-device.html
---
# HTTP device

![HTTP device]({{ site.img }}/reference/devices/http.png "HTTP device")

Connect *score* to web APIs, cloud services, IoT platforms, and HTTP-based systems. Send requests and receive responses from any HTTP/HTTPS service, enabling integration with modern web-connected devices and services.

Perfect for IoT installations, social media integration, cloud data access, or controlling web-connected lighting, sensors, and automation systems.

## Setting up an HTTP device

1. **Add device** in the [[Device explorer]] and choose "HTTP"
2. **Configure base URL** for your target API or service
3. **Set authentication** if required (API keys, tokens, basic auth)
4. **Define endpoints** for the services you want to access
5. **Test connection** with a simple GET request

Most modern APIs use JSON formatting and RESTful conventions, which HTTP device handles automatically.

## Communication capabilities

### HTTP methods
**GET** - Retrieve data from APIs, sensors, or web services  
**POST** - Send data to services, trigger actions, or submit forms  
**PUT** - Update existing resources or configurations  
**DELETE** - Remove data or disable services  
**PATCH** - Partial updates to existing resources

### Data formats
**JSON** - Modern API standard with automatic parsing and generation  
**XML** - Legacy format support for older systems  
**Plain text** - Simple string data for basic services  
**Form data** - Traditional web form submissions

### Authentication
**API keys** - Bearer tokens, API key headers, or URL parameters  
**Basic authentication** - Username and password combinations  
**OAuth** - Modern token-based authentication (with manual token management)  
**Custom headers** - Custom authentication schemes and API requirements

## Creative applications

**IoT integration**: Control Philips Hue lights, read weather data, or integrate with home automation systems for responsive installations.

**Social media interaction**: Pull live Twitter feeds, Instagram posts, or other social data to influence musical or visual content.

**Cloud data sources**: Access real-time stock prices, news feeds, or scientific data to drive algorithmic compositions.

**Sensor networks**: Read from distributed HTTP-enabled sensors for large-scale environmental installations.

**Content management**: Update visual content, text displays, or media files based on web-based content management systems.

## Integration with score processes

**Data parsing**: Use response data to control [[Mapping Tool]] for converting web data into musical parameters.

**Real-time polling**: Set up periodic requests to get live data that influences [[Audio Effects]], [[Video]] processing, or spatial audio positioning.

**Event triggering**: Use HTTP responses to trigger [[Scenario]] elements, change scenes, or start automation sequences.

**Parameter control**: Map API data to any *score* parameter for web-controlled installations and performances.

## Example integrations

### Weather-responsive music
```
HTTP GET → Weather API → Temperature data → Mapping Tool → Audio Effects
```
Music that changes based on current weather conditions.

### Smart lighting control
```
Score parameters → HTTP POST → Philips Hue API → Color and brightness changes
```
Synchronize lighting with musical or visual content.

### Social media sonification
```
HTTP GET → Twitter API → Tweet sentiment → MIDI generation → Musical output
```
Convert social media activity into musical expressions.

### IoT sensor reading
```
HTTP GET → Sensor API → Environmental data → Spatial audio positioning
```
Use distributed sensors to control sound positioning in installations.

## Technical considerations

**Request rates**: Respect API rate limits to avoid being blocked - use appropriate polling intervals.

**Error handling**: APIs can be unreliable - implement fallback behaviors for network failures or service outages.

**Authentication security**: Store API keys and tokens securely, rotate credentials regularly for production systems.

**Data validation**: Validate API responses before using them to control parameters - unexpected data can cause system instability.

## Performance optimization

**Caching**: Store frequently accessed data locally to reduce API calls and improve response times.

**Asynchronous requests**: HTTP device handles requests asynchronously to prevent blocking *score*'s real-time performance.

**Connection pooling**: Reuse connections when making multiple requests to the same service.

**Timeout management**: Set appropriate timeouts to prevent hanging requests from affecting performance.

## Troubleshooting

**Connection failures**: Check network connectivity, verify URLs are correct, ensure firewall settings allow outbound HTTP/HTTPS.

**Authentication errors**: Verify API keys are current and correctly formatted, check for expired tokens or changed authentication requirements.

**Rate limiting**: If requests are being rejected, reduce polling frequency or implement request queuing.

**Data parsing issues**: Verify API response formats match expectations, implement error handling for malformed JSON or XML.

The HTTP device works excellently with [[OSC]] for hybrid network protocols, data processing through [[Mapping Tool]], or trigger systems for event-based interactions.

## Related devices

Combine with [[OSC]] for comprehensive network communication, use with [[MQTT]] for IoT messaging protocols, or integrate with [[WebSocket]] for real-time bidirectional web communication.