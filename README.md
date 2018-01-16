# The Metrics System

## _Because dad jokes are fun_

This is an app for tracking any event you like (link clicks, page loads, etc) in a type-agnostic manner. Register your app with TheMetricsSystem, add a small javascript snippet to your code that will report to this API (sending only an event name of your choosing), and you can log in to view graphic representations of any events that have been tracked on your app.

## Trying it out

- get the gem dependencies by running `bundle install`

- create and seed a sample database to populate the app using `rake db:create` and `rake db:setup`

- run the app with `rails s` and navigate your browser to `localhost:3000`

## Testing it without a login

- so that you can easily check it out, the seeds file comes preset with `member@example.com` using password `helloworld`. This user will have some fake apps already registered and fake events already created so you can view the interface and graphs. The seeds file also generates some other users and their apps, but this is only to illustrate that unrelated data doesn't bleed through.

- the seeds file also registers `YourTestApp` at `localhost:4000`. You can use this one to see events coming in in real time. Another one of my apps, Read-It, has a branch called "metrics" which is preloaded with javascript so that it will report to TheMetricsSystem any time you click the "submit" button on a New Post form. Open a second terminal window, run the second app using `rails s -p 4000`, and when you submit a new post on Read-It you will be able to see this event on `YourTestApp`.

## Testing it on your own apps

- you are welcome to log in under your own name, and register the url of an app you own.

- first, add this javascript somewhere central to your app (in my example, using a rails app, I put it in the application.js file)

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

- next, attach calls to this function in places where you want notifications. You can put it in a script tag to track a page load, on a button or link to track clicks, etc. For an example, this is what is on my New Post "submit" button in Read-It:

`<%= f.submit "Save", class: 'btn btn-success', onclick: "metricsSystem.report('New Post Created')" %>`

- the script is written in native AJAX so you do not need JQuery for it to work
