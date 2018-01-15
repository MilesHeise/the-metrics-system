# The Metrics System

## _Because dad jokes are fun_

This project is in early stages. Proper ReadMe file coming once there's something to read about . . .

things to add when finishing readme. how to use metrics on new page. how to use pre-seeded metrics with other existing app. note read-it "metrics" branch, note `rails s -p 4000`, note this JS snippet:

```javascript
var metricsSystem = {};
metricsSystem.report = function(eventName) {
  var event = {
    event: {
      name: eventName
    }
  };
  var request = new XMLHttpRequest();
  request.open("POST", "http://localhost:3000/api/events", true);
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.stringify(event));
}
```

`<%= f.submit "Save", class: 'btn btn-success', onclick: "metricsSystem.report('New Post Created')" %>`

note can also be activated on page load, etc.
