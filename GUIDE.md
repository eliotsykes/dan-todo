# App Development Guide

## public/index.html is an app

```bash
cd my-rails-app
git co -b index-html-app
```

Create `public/index.html` with some intentionally simple content. For example:

```html
<!DOCTYPE html>
<html>
<head>
  <title>Todos</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Don't worry about stylesheets and scripts for now -->
</head>
<body>
  <h1>Todos</h1>
  <ul>
    <li>Get milk</li>
    <li>Read book</li>
    <li>Find tickets</li>
  </ul>
  <button onclick="alert('Thank You!');">Press Me</button>
</body>
</html>
```

Run `bin/rails s`, visit http://localhost:3000 and check you see `public/index.html`.

It may not seem like much now, but this HTML page is where your app begins. You'll add features soon, but first you're getting this app on to your phone.

