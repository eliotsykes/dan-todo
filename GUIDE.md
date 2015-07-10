# App Development Guide

<!-- MarkdownTOC depth=0 autolink=true bracket=round -->

- [public/index.html is an app](#publicindexhtml-is-an-app)
- [Getting the app on your phone for development](#getting-the-app-on-your-phone-for-development)
  - [`bin/phonegap`](#binphonegap)
- [Use PhoneGap Build to create platform distributions](#use-phonegap-build-to-create-platform-distributions)
- [Install `.apk` file on Android](#install-apk-file-on-android)
  - [Genymotion Android Emulator Installation (move to Appendix)](#genymotion-android-emulator-installation-move-to-appendix)
- [TODO: Install `.xap` file on Windows](#todo-install-xap-file-on-windows)
- [TODO: Install `.ipa` file on iOS](#todo-install-ipa-file-on-ios)
  - [Coming Next...](#coming-next)
- [Ember and how to make a good enough choice of framework](#ember-and-how-to-make-a-good-enough-choice-of-framework)
  - [Coming Next...](#coming-next-1)
- [How to install Ember](#how-to-install-ember)
- [Creating a New Ember Application](#creating-a-new-ember-application)
  - [Install npm dependencies](#install-npm-dependencies)
  - [Install Bower as npm dependency](#install-bower-as-npm-dependency)
  - [Install Bower dependencies](#install-bower-dependencies)
  - [Serve the Ember app](#serve-the-ember-app)
  - [`bin/ember`](#binember)
- [Ember at the front, Rails at the back](#ember-at-the-front-rails-at-the-back)
  - [Coming Next...](#coming-next-2)
- [Run multiple processes in one command with Foreman](#run-multiple-processes-in-one-command-with-foreman)
- [Move `index.html` to Ember](#move-indexhtml-to-ember)
- [Configuring Ember and PhoneGap](#configuring-ember-and-phonegap)
  - [Ember Router `locationType`](#ember-router-locationtype)
  - [Unify PhoneGap and Ember](#unify-phonegap-and-ember)
  - [Manage `phonegap serve` with Foreman](#manage-phonegap-serve-with-foreman)
  - [PhoneGap Build and run the Ember app](#phonegap-build-and-run-the-ember-app)
- [How to deploy an Ember-Rails app to Heroku](#how-to-deploy-an-ember-rails-app-to-heroku)
  - [Hiding `Procfile` from Heroku](#hiding-procfile-from-heroku)
  - [Join Heroku](#join-heroku)
  - [Heroku buildpacks](#heroku-buildpacks)
  - [Heroku's Multi Buildpack](#herokus-multi-buildpack)
  - [Create a Heroku app](#create-a-heroku-app)
  - [Prepare for Node.js Buildpack](#prepare-for-nodejs-buildpack)
    - [Edit `package.json`](#edit-packagejson)
  - [Prepare for Ruby Buildpack](#prepare-for-ruby-buildpack)
  - [First Deploy!](#first-deploy)
  - [Second Deploy!](#second-deploy)
  - [Coming Next...](#coming-next-3)
- [User Registration](#user-registration)
  - [Preparing for testing](#preparing-for-testing)
  - [BDD: Writing and passing user registration spec](#bdd-writing-and-passing-user-registration-spec)
    - [Ember Pods](#ember-pods)
    - [Ember Route Generation](#ember-route-generation)
    - [Ember Helpers](#ember-helpers)
    - [Ember Model for User](#ember-model-for-user)
    - [Ember Components](#ember-components)
    - [Registration Form Component](#registration-form-component)
    - [Ember Initializers](#ember-initializers)
    - [API Design and Ember's RESTAdapter](#api-design-and-embers-restadapter)
    - [User API Request Spec](#user-api-request-spec)
    - [API Routing](#api-routing)
    - [API Controller](#api-controller)
    - [Registration Confirmation Email](#registration-confirmation-email)
    - [Rails and JSON case conventions](#rails-and-json-case-conventions)
    - [Styling CSS in Ember](#styling-css-in-ember)
    - [Preprocessing CSS in Ember](#preprocessing-css-in-ember)
      - [Sass](#sass)
      - [Autoprefixer](#autoprefixer)
    - [Write the body-class helper](#write-the-body-class-helper)
    - [Form Submit & Transitioning Routes](#form-submit--transitioning-routes)
    - [Confirm Registration & Login](#confirm-registration--login)
      - [Redirect to login page after confirmation](#redirect-to-login-page-after-confirmation)
      - [Notifier component](#notifier-component)
- [How login will work](#how-login-will-work)
- [Session Authentication API](#session-authentication-api)
- [Login Form Component](#login-form-component)
- [Notifier Ember Service](#notifier-ember-service)
- [Design the Notifier Service](#design-the-notifier-service)
- [Write the Notifier Service](#write-the-notifier-service)
- [Notifier Initializers](#notifier-initializers)
- [Feature Spec Check-in](#feature-spec-check-in)

<!-- /MarkdownTOC -->


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

Run `bin/rails s`, visit [http://localhost:3000](http://localhost:3000) and check you see `public/index.html`.

It may not seem like much now, but this HTML page is where your app begins. You'll add features soon, but first you're getting this app on to your phone.


## Getting the app on your phone for development

Install PhoneGap command line client:

```bash
# Assumes node and npm are installed.
# -g flag installs phonegap globally:
npm install -g phonegap
# npm not available? Install npm+node via nvm: https://github.com/creationix/nvm
```

Make a new subdirectory, 'client/wrap', in your existing Rails application. This is the directory PhoneGap will perform its work in:

```bash
# Inside my-rails-app/ directory:
mkdir -p client/wrap
```

Create a new PhoneGap app, using `--id` and `--name` options of your choice. For example:

```bash
# Inside my-rails-app/ directory:
phonegap create client/wrap --link-to public --id "com.appsfromdan.todo" --name "My Todos"
```

This will create a few directories in `client/wrap`, including a `www` directory symlink which resolves to the Rails `public/` directory, where PhoneGap expects to find `index.html`.

Install the PhoneGap Developer app on a phone or tablet that you have connected to the same Wi-Fi network that your computer is connected to. This phone/tablet is the first device you will test your app on. The PhoneGap Developer app can be installed free from the major app stores and is made by Adobe:

- [Apple App Store (iOS) - install PhoneGap Developer](https://itunes.apple.com/app/id843536693)
- [Google Play (Android) - install PhoneGap Developer](https://play.google.com/store/apps/details?id=com.adobe.phonegap.app)
- [Windows Phone Store - install PhoneGap Developer](http://www.windowsphone.com/en-us/store/app/phonegap-developer/5c6a2d1e-4fad-4bf8-aaf7-71380cc84fe3)

To see our own app on the device, startup the PhoneGap server from the command line. Pay special attention to the the IP address and port number output, you'll be needing this shortly:

```bash
# Inside my-rails-app/ directory:
cd client/wrap/

# Start up the PhoneGap server:
phonegap serve

# Output from server will look like:
[phonegap] starting app server...
[phonegap] listening on AN_IP_AND_PORT_ON_YOUR_NETWORK
```

Open the PhoneGap Developer app on your device. Enter the IP address and port given in the output from the PhoneGap server. You can enter these details by tapping on the "Server Address" field displayed in the PhoneGap Developer app. Then tap the Connect button.

Assuming there are no network issues (check the device and the computer are on the same network), your app will appear on your device. You should see the `index.html` you created on your device, congratulations! 

This is your basic development environment. Any changes you make to `public/index.html` will be detected by PhoneGap which will tell your device to reload your app.

Check PhoneGap's auto-reload feature is working by saving a minor edit to `public/index.html` on your computer. Check you can see the change appear on the device within a few seconds. The log output from PhoneGap server ought to be similar to this:

```bash
[phonegap] file changed /some/path/to/client/wrap/www/index.html
[phonegap] 200 /__api__/autoreload
[phonegap] 200 /
[phonegap] 200 /socket.io/?EIO=2&transport=polling&t=1234567890123-1&sid=abc1xyzA12BcdefgWXYZ
```

Add the changes in your app, including the new `client` directory to version control.

### `bin/phonegap`

Currently we have to remember to `cd` into the `client/wrap` directory to run `phonegap serve` correctly. This is an extra step that can be easily forgotten, so lets capture this knowledge in a wrapper script in the `bin/` directory. This will save us having to remember to do this in the future when we want to use the `phonegap` command.

Create a new file `bin/phonegap` and make it executable:

```bash
# Inside my-rails-app/ directory:
touch bin/phonegap

# Make the phonegap wrapper script executable:
chmod +x bin/phonegap
```

Open `bin/phonegap` in your editor and save it with these contents:

```bash
#!/usr/bin/env sh

# Thin wrapper script to execute phonegap commands in the correct working directory. 
# All phonegap commands need to be run inside the client/wrap dir. To save remembering
# to change directories, just run `bin/phonegap ...` from the project root. All
# phonegap commands will work. For usage enter `bin/phonegap --help`

# phonegap command working directory must be client/wrap:
cd client/wrap

# Ensure path symlinked to from www exists to make phonegap serve happy:
symlink_target_path=$(readlink www)
mkdir -p $symlink_target_path

# Forward args to bin/phonegap to npm-installed phonegap command:
phonegap "$@"

# Return to project root:
cd ../..
```

From now on, if you want to run any `phonegap` commands, run them using `bin/phonegap` as this will make sure they're executed in the correct working directory. For example, to start the PhoneGap server, we would now just run this command in the terminal:

```bash
# Inside your-rails-app/ directory:
bin/phonegap serve
```

Now's a good time to add some brief usage information about `bin/phonegap` to your README.

Commit this latest set of changes to your repo.

In the next stage you'll get to compile your app so it can be installed on devices *without* installing the PhoneGap Developer app.


## Use PhoneGap Build to create platform distributions

Adobe's PhoneGap Build is a service with a free option that simplifies the process of creating distribution files for three major platforms: Android, iOS, and Windows Phone 8.

PhoneGap Build takes an upload of a zip file of your app and creates a distribution file for each platform you specify.

At a later stage, we'll configure your development computer to support building distributions without PhoneGap Build. This will give you the power to distribute your app to all these platforms: iOS, Android, Windows, Amazon Fire OS, Firefox OS, Ubuntu, Tizen, and Blackberry 10.

Sign up for the PhoneGap Build free plan at [https://build.phonegap.com/](https://build.phonegap.com/) and login.

Create the zip file of your app for upload to PhoneGap Build:

```bash
# Inside my-rails-app/ directory:
cd client/wrap/www

# Create the zip file of the contents of the www directory:
zip -r ../phonegap-build-source-app.zip .
```
There should now be a zip file at this location inside your Rails app:

```
# Check zip file exists here:
client/wrap/phonegap-build-source-app.zip
```

Tell Git to ignore the zip files. Add this line to `my-rails-app/.gitignore`:

```bash
/client/wrap/*.zip
```

Log on to PhoneGap Build to setup and build your app:

- Visit [https://build.phonegap.com/apps](https://build.phonegap.com/apps)
- Choose "Private" tab
- Click the "Upload a .zip file" button
- Select the zip file to upload: `my-rails-app/client/wrap/phonegap-build-source-app.zip`
- Once upload completes, change the name of the app to something descriptive (e.g. Todos App)
- Click the "Ready to build" button. 

PhoneGap Build will start building the platform versions of your app. 

The iOS version will fail which is normal, more setup and joining the Apple Developer Program is needed for iOS (which we'll dive into later). However, the Android and Windows builds should complete successfully!

## Install `.apk` file on Android

Every Android app is distributed as an APK (Android application package) file with the `.apk` extension.

PhoneGap Build produces an APK file for you to install on Android devices you want to test your app on. (If you don't have an Android device handy, you can use the Genymotion Android emulator at [https://www.genymotion.com](https://www.genymotion.com)).

Download and save the APK file by clicking on the Android icon for your app on PhoneGap Build.

Next, copy the APK file from your computer on to your Android device. Choose the method that is most convenient for you:

- Connect device to computer by USB and copy file to the device
- Email the APK file as an attachment to yourself and open the email on your device
- Dropbox or similar cloud storage service
- Any other method you use for copying files to your Android device

Once the APK is on the device, open the device's File Explorer/Browser app, navigate to where you've saved the APK, and open it. Follow the prompts to install the app on your device. (If you're not prompted to install the app, go into your phone settings and enable the option to allow apps from Unknown Sources to be installed).

When app installation is complete, open the app, and check it looks as you expected (there may be a blank screen for a few seconds while the app loads).

### Genymotion Android Emulator Installation (move to Appendix)

- Sign up for the Genymotion free plan [https://www.genymotion.com](https://www.genymotion.com)
- Download and install the Genymotion application on your computer
- Open the Genymotion application
- Follow the prompts in Genymotion to setup an emulator for any one of the supported Android devices
- Start the emulator device in Genymotion
- Drag and drop the .apk file onto the Genymotion emulator window. Follow the prompts to install the app and run it inside the emulator.

## TODO: Install `.xap` file on Windows
## TODO: Install `.ipa` file on iOS


### Coming Next...

Now you've setup a workflow for developing your app for real devices, we can begin work on replacing the static `index.html` app with a full featured application that works as an installable app **and** as a good old web app in any browser.

## Ember and how to make a good enough choice of framework

[Ember](http://emberjs.com/) is an established, open-source JavaScript framework that has been influenced in its design and community philosophy by Rails. Many Ember contributors and users use Rails as their backend of choice, paired with an Ember frontend (Ember may also be used with non-Rails backends).

Ember favors convention over configuration. This means that you don't have to think hard about where to put a new script, stylesheet, or other asset. 

In Rails there are directories for configuration code, models, controllers, views, and so on. Rails developers know where to put a new model, it goes in the `app/models` directory. Similarly, Ember has directories and conventions to help you organize your codebase and make it less likely your brain blows a fuse when jumping between projects that use the same framework.

Ember provides a command line interface known as [Ember CLI](http://www.ember-cli.com/) that is invoked on the command line as `ember`. When developing Ember applications, you tend to use the `ember` command in ways that are similar to how you use the `rails` command.

Thankfully -- as it creates a thriving, evolving JavaScript ecosystem -- not all developers will agree with what I'm about to write and that's okay. 

I feel Ember is a good default choice JavaScript framework for most Rails web applications that also want to distribute apps in the app stores across all of the PhoneGap-supported operating systems. Ember will allow us to reuse and share templates throughout our app. Ember CLI will keep us from having to write many, if any, command line tools.

I think it is rare that Ember will be a *bad* choice when choosing a JavaScript framework for an app store capable Rails app. However, that doesn't mean it is always the *best* choice. I strongly recommend you consider experimenting with other JavaScript libraries when choosing your own application architecture and take into account your own requirements. Other frameworks to consider include: AngularJS, Ionic, and React.

When making your choice of framework, here are some guidelines and considerations that may prove helpful:

- Do you need to run a web app and app store apps?
- Which of the app stores does your app need to be in now and in the future? Does the framework support all of these platforms?
- Is server-side rendering important? This can be important for:
  - Search engine indexing
  - SEO
  - Low "start render" time (affects user-perceived performance and can be an important factor in conversion rate optimization for ecommerce)
  - Progressive enhancement
  - Fault tolerance and delivering accessible content under poor network conditions, such as slow and patchy mobile networks
- Do the phone/tablet apps need to use the same view templates as the web app or is it acceptable to maintain two sets of templates, one set for the device apps, and one set for the web app?
- How much experience do you and/or your teammates have with the framework?
- Does the framework have good documentation and training resources?
- How much experience do developers in your hiring pool have with the framework? Can you afford time to train developers in the ways of the framework?
- How organized are your current frontend JavaScript codebases? Would you want the framework to provide conventions for organizing your files and assets?
- Do you want the framework to have testing support baked in?
- Are other teams and businesses successfully and happily using the framework in existing applications that are similar to what you're working on?


Take mine and other developer's claims about frameworks with a pinch of salt. Be especially wary of developers claiming their framework is the one-framework-to-rule-them-all. 

Each framework has its own advantages and disadvantages that vary depending on your unique requirements. Make time to do good research. Try frameworks out. Prototype. Make your own objective decision. Taking time up-front will likely save you time in the long run by helping you make an informed choice.

### Coming Next...

We'll setup Ember on your computer and create a new application inside the `your-rails-app/client` directory using Ember CLI.


## How to install Ember

If you've never installed Ember before:
```bash
# Install Ember CLI. The -g option makes
# the `ember` command available globally:
npm install -g ember-cli
```

Otherwise and **only** if you've previously installed Ember, then follow these instructions (original source: https://github.com/ember-cli/ember-cli/releases):
```bash
# Remove old global ember-cli:
npm uninstall -g ember-cli

# Clear NPM cache:
npm cache clean

# Clear Bower cache (assuming bower installed globally,
# may not be, then run `npm install -g bower`)
bower cache clean

# Install new global ember-cli:
npm install -g ember-cli
```


## Creating a New Ember Application

You're about to create the Ember app using the `ember init` command:

```bash
# Be in the client/ directory:
cd my-rails-app/client

# Initialize a new ember application in the current directory,
# and feel free to change the application name from todos:
ember init --name todos --skip-npm --skip-bower
```

The `--skip-npm` and `--skip-bower` options were given to `ember init` to stop Ember's dependencies (these are conceptually similar to how Rails apps have gem dependencies) from being installed in the `client/node_modules` (used by npm to keep Ember's development dependencies) and `client/bower_components` (used by Bower to keep Ember's frontend dependencies) directories.

Instead of using the `client/` directory for these dependencies, we're going to install these dependencies in the project root, under the `my-rails-app/node_modules` and `my-rails-app/bower_components` directories. This will pay off later by simplifying our production environment deployment to Heroku.

Add the generated Ember app to your repo.

### Install npm dependencies

npm dependencies are specified in `client/package.json` under the `devDependencies` configuration. These are the dependencies needed to build and serve the Ember app (they are *not* runtime dependencies required in the browser. Browser runtime dependencies are managed by Bower).

npm always installs its dependencies in a directory named `node_modules` that is in the same directory as the `package.json` file. 

To get the npm dependencies installed in `node_modules/` in our project root, perform the following:

```bash
# Inside my-rails-app/ directory:

# Move package.json to project root to satisfy npm (and later Heroku):
mv client/package.json ./

# Install the dependencies (this may take a while):
npm install

# Check you can see the dependencies directory and it contains directories that
# match the names under devDependencies in package.json:
ls -al node_modules/

# Symlink node_modules and package.json from client/ so ember operates without error:
ln -s ../node_modules client/node_modules
ln -s ../package.json client/package.json
```

Remove this line from `client/.gitignore` so the symlink at `client/node_modules` can be tracked in version control:

```
/node_modules
```

Then **add** these lines to `.gitignore` in `my-rails-app/` so the `node_modules/` directory and its contents are **not** tracked by git (they don't need to be as they are derived from `package.json` which is already tracked by git):

```
# Ignore local npm dependencies as they are derived from package.json
/node_modules
```

The npm dependencies have been installed. Commit all of the above changes to your git repository.


### Install Bower as npm dependency

For deployment to Heroku, Bower needs to be installed as an npm development dependency. Let's add it now:

```bash
# Inside your-rails-app/ directory:
npm install --save-dev bower
```

This will install Bower and add it to `package.json` under `devDependencies`. Do a `git diff` to see the change. Commit the updated `package.json` to your repository.

### Install Bower dependencies

Bower dependencies are specified in `client/bower.json` under the `dependencies` configuration. These are the dependencies needed at in the browser to successfully run an Ember application.

Bower installs its dependencies in a directory named `bower_components` that is in the same directory as the `bower.json` file. 

To get the Bower dependencies installed in `bower_components/` in our project root, perform the following:

```bash
# Inside my-rails-app/ directory:

# Move bower.json and .bowerrc to project root:
mv client/bower.json ./
mv client/.bowerrc ./

# Install the dependencies (this may take a while):
bower install

# Check you can see the dependencies directory and it contains directories that
# match the names under dependencies in bower.json:
ls -al bower_components/

# Symlink bower_components, bower.json, and .bowerrc from client/ so ember operates without error:
ln -s ../bower_components client/bower_components
ln -s ../bower.json client/bower.json
ln -s ../.bowerrc client/.bowerrc
```

Remove this line from `client/.gitignore` so the symlink at `client/bower_components` can be tracked in version control:

```
/bower_components
```

Then **add** these lines to `.gitignore` in `my-rails-app/` so the `bower_components/` directory and its contents are **not** tracked by git (they don't need to be as they are derived from `bower.json` which is already tracked by git):

```
# Ignore local bower dependencies as they are derived from bower.json
/bower_components
```

The Bower dependencies have been installed. Commit all of the above changes to your git repository.


### Serve the Ember app

Now the dependencies have been installed, it's a good idea to check that the ember app and development environment is working okay:

```bash
# Be in the client/ directory:
cd my-rails-app/client

# Run Ember server:
ember s
```

Once the Ember server is up and running, visit [http://localhost:4200/](http://localhost:4200/) in your browser. If everything is working as expected, you should see a page with the message "Welcome to Ember.js".

Stop the Ember server by pressing `Ctrl+C`.


### `bin/ember`

Currently we have to remember to `cd` into the `client` directory to run `ember` commands. This is an extra step that can be easily forgotten. Capture this knowledge in a wrapper script in the `bin/` directory.

Create a new file `bin/ember` and make it executable:

```bash
# Inside my-rails-app/ directory:
touch bin/ember

# Make the ember wrapper script executable:
chmod +x bin/ember
```
Open `bin/ember` in your editor and save it with these contents:

```bash
#!/usr/bin/env sh

# Thin wrapper script to execute ember commands in the correct working directory. 
# All ember commands need to be run inside the client/ dir. To save remembering
# to change directories, just run `bin/ember ...` from the project root. All
# ember commands will work. For usage enter `bin/ember --help`

# ember command working directory must be client/:
cd client

# Forward args to npm-installed ember command:
ember "$@"

# Return to project root:
cd ..
```

From now on, if you want to run any `ember` commands, run them using `bin/ember` as this will make sure they're executed in the correct working directory. For example, to start the Ember server, we would now just run this command in the terminal:

```bash
# Inside your-rails-app/ directory:
bin/ember serve
```

Consider briefly documenting `bin/ember` in your application's README for reference for your future self.

Commit the changes we've made to your repo.


## Ember at the front, Rails at the back

Its time to get our Ember and Rails apps working together in our development environment.

The Rails app is going to be responsible for delivering the Ember application files to the browser and will handle all API requests.

The Ember app is going to be responsible for the frontend and will run in the browser.

To support this in the development environment, you'll run two processes:

1. `bin/rails server` to serve requests for the API coming from the frontend, *and* to deliver the Ember application files to the browser
2. `bin/ember build` to build your Ember app files into a directory that Rails will serve them from

By default, your Rails app is configured to serve static files, such as `index.html`, `404.html`, `robots.txt`, and `favicon.ico` from the `public/` directory. Let's configure it to instead serve files from a directory that the Ember application will be built to.

The Ember application will be built into the `client/dist` directory. This is the directory we want to replace the Rails `public/` directory with. Create a new initializer script at `your-rails-app/config/initializers/public_path.rb` with the following contents:

```ruby
# Set public path to be the Ember-managed client/dist directory:
Rails.application.config.paths["public"] = File.join("client", "dist")
```

Move the following files from `public` to `client/public` to migrate them to Ember:

```bash
cd public
mv 404.html 422.html 500.html favicon.ico robots.txt ../client/public/
# Do *not* move public/index.html
```

When we briefly ran the Ember server earlier, Ember built files into the `client/dist` directory. This is normal, but for now, to avoid the distraction of some unimportant logging messages, clear out the current contents of the `client/dist/` directory:

```bash
# Inside my-rails-app/ directory:
rm -Rf client/dist/*
```

Now start a process to do a fresh build of Ember that will automatically and conveniently rebuild any files that are changed while you're developing:

```bash
# Builds Ember's files to client/dist/ and watches for changes to Ember's files:
bin/ember build --watch
```

`bin/ember build --watch` is going to continue running while we develop. Next, open a new terminal tab and start the Rails server:

```bash
# In a new terminal tab, start the Rails server:
bin/rails s
```

Once `bin/rails s` is running, visit [http://localhost:3000/](http://localhost:3000/) in your browser. You should see a page with the headline "Welcome to Ember.js". This page is being served by your Rails server. The contents of the page are the Ember app. The file for this page is `client/dist/index.html`.

Let's check that changes you make to the Ember app during development are picked up in the browser.

In your editor, open the Ember template located at `client/app/templates/application.hbs`. It will contain the "Welcome to Ember.js" headline. Change this headline text to "Hello World" and save the file.

In the browser, refresh [http://localhost:3000/](http://localhost:3000/), and you should see the "Hello World" headline, which means congratulations, you've successfully put together a working development workflow.

Stop both the Rails server and Ember build processes with `Ctrl+C` in each terminal tab.

Save the changes we've made to your application to your repository.

### Coming Next...

Next we'll save ourselves time and precious keystrokes by using the Foreman gem to manage the `bin/rails s` and `bin/ember build` commands in our development environment.


## Run multiple processes in one command with Foreman

[Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html) is the simplest way I've encountered to run the multiple processes that advanced Rails applications often need.

In this particular app, we've got two processes that need managing in our development environment: the `bin/ember build --watch` process, and the `bin/rails s` process.

Foreman is a gem that reads and runs the processes you want managed from a `Procfile`. Each line in the `Procfile` contains a name for a process and the command used to start that process. 

Create `my-rails-app/Procfile` with these contents, which defines two named processes, `rails` and `ember`:

```
rails: bin/rails server
ember: bin/ember build --watch
```

In the terminal, install the foreman gem:

```bash
gem install foreman
```

Finally, run the `foreman start` command (or `foreman s` for short) to get Foreman running your `ember` and `rails` processes:

```bash
foreman s
```

Lets check this is working correctly. Visit [http://localhost:3000/](http://localhost:3000/) and check you see the "Hello World" headline from the Ember app.

`foreman s` is simpler to remember and faster to type than if we tried to manage the two `rails` and `ember` processes separately in their own terminal tabs. If we bring other developers on board it should also make it more straightforward for them to get the app up and running on their machine.

Quit foreman and its managed processes with `Ctrl+C`.

Now might be a good opportunity to briefly document `gem install foreman` and `foreman s` in your application's README.


## Move `index.html` to Ember

Now's almost a good time to move the code out of `public/index.html` and make it part of the Ember app under `client/`. First let's touch on how Ember organizes its HTML.

The Ember app has its own `index.html` at `client/app/index.html`. We're not going to change this for a while, but it's good to take a look at it so you can get more familiar with how Ember renders HTML.

In `client/app/index.html`, you'll see the structure for an HTML document, including the `<html>`, `<head>`, and `<body>` elements. This `index.html` is the file Ember uses as its layout for all of its views. The Ember view templates you write will ultimately end up rendered inside this skeleton HTML structure, usually in the `{{content-for 'body'}}` section.

When using the Ember app in your browser, the `{{content-for 'body'}}` section is dynamically replaced with the contents of `client/app/templates/appliation.hbs`. 

The `.hbs` file extension denotes a Handlebars template. Note the exception that `client/app/index.html` is also a Handlebars template although it doesn't have the `.hbs` file extension.

Handlebars templates look like HTML with snippets wrapped in double braces, e.g. `{{title}}` and `{{content-for 'body'}}`. These double brace snippets are known as "handlebar expressions".

Replace the `<h2>` title element in `client/app/templates/application.hbs` with the content from *inside* the `<body>` tag of `public/index.html`.

Be sure to *keep* the `{{outlet}}` handlebars expression at the end of `application.hbs`. `application.hbs` should now look like this:

```html
<h1>TODOS</h1>
<ul>
  <li>Get more milk</li>
  <li>Read book</li>
  <li>Find tickets</li>
</ul>
<button onclick="alert('Thank You!');">Press Me</button>

{{outlet}}
```

Delete `public/index.html`:

```bash
rm public/index.html
```

Run `foreman s` inside the `my-rails-app/` directory, and visit [http://localhost:3000](http://localhost:3000) to check you see these changes.

Press `Ctrl+C` to stop the Foreman processes.


## Configuring Ember and PhoneGap

Since introducing Ember into our application, we've got our Rails development environment up and running to work with it successfully and simply thanks to Foreman.

There's a little more re-organization and configuration of our application to do so it'll work as a PhoneGap app.

### Ember Router `locationType`

The Ember Router is responsible for routing client-side URLs to execute the right part of the Ember app. It might help to think of it as having a similar responsibility to Rails' server-side routing and `routes.rb` file.

The Ember Router is configured with a `locationType` which can be one of: `auto`, `hash`, `history`, and `none`. The chosen option alters how URLs appear in the address bar and what browser API is used to manipulate the current URL.

The `auto` option tries to pick the most appropriate option out of the other options, based on the capabilities of the browser.

`history` is used if the browser supports the [JavaScript History API](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Manipulating_the_browser_history).

`hash` depends on the `hashchange` event and using hashes in the URL. The `hash` option is used as a fallback when the browser doesn't support the History API.

When compiled PhoneGap apps run, `index.html` isn't served over the `http:` protocol as is usual with HTML pages in a web browser environment. Instead `index.html` is served off the local filesystem of the device, which means the protocol is `file:` not `http:`. You can see this protocol in use in your own browser if you open any HTML file on your computer using the `File > Open` menu.

For security reasons, History API support is patchy when used in some browsers with pages served over the `file:` protocol. For our Ember app to work in the PhoneGap environment, it needs to use `hash` for `locationType`.

Open `client/config/environment.js` and change the `locationType` option from `auto` to `hash`:

```javascript
    ...
    // 'history' locationType not supported in compiled PhoneGap apps, use 'hash':
    locationType: 'hash',
    ...
```

### Unify PhoneGap and Ember

The PhoneGap `www` directory and Ember `dist` directory are where both frameworks respectively expect to find the `index.html` and other application asset files.

To enable us to easily use the Ember app as our PhoneGap app, we'll make these directories point to the same location with a symlink.

Delete the current `www` symlink and create a new symlink to replace it:

```bash
# Inside my-rails-app/ directory:
cd client/wrap

# Remove www:
rm www

# Symlink to Ember's dist directory:
ln -s ../dist www
```

Check the symlink created successfully, open `client/wrap/www/index.html` and check its the same as the file at `client/dist/index.html`.


### Manage `phonegap serve` with Foreman

Foreman will now manage a third process for us, the `phonegap serve ...` process. Edit your `Procfile` so it looks like this:

```
rails: bin/rails server --port 3000
ember: bin/ember build --watch
phonegap: bin/phonegap serve --port 4000
```

In `Procfile` we specify port numbers for the `rails` and `phonegap` processes. We've done this as both processes conflict if we don't as they both try to use port 3000.

Now run `foreman s` and we'll check the server processes are working as expected.

Visit [http://localhost:3000](http://localhost:3000) in your web browser and check you see the Ember app. This proves the `rails` process is still working correctly.

Look for output like this from `foreman s` to identify the IP address and port number you'll input into your PhoneGap Developer app on your test device:

```
16:51:38 phonegap.1 | [phonegap] listening on XXX.XXX.XXX.XXX:4000
```

Open the PhoneGap Developer app on your test device and enter the IP address and port number output by your Foreman `phonegap` process, and click the Connect button. Everything is working correctly if you see the Ember app on your test device inside the PhoneGap Developer app.


### PhoneGap Build and run the Ember app

Ember has multiple environments: `development`, `test`, and `production`.

This is much like Rails, including the ability to configure each environment differently.

We're not about to change this file, but quickly take a look at `client/config/environment.js` so you're familiar with where environment-specific configuration goes in an Ember app. You'll see three if blocks, one for each environment:

```javascript
  ...

  if (environment === 'development') {
  
  ...
  
  if (environment === 'test') {

  ...

  if (environment === 'production') {

  ...

```

The web app we upload to the PhoneGap Build server from now on will be built with the Ember `production` environment. This is done by passing the `--environment` flag to `bin/ember build`.

Perform the commands below to create a new zip file to upload to PhoneGap Build.

```bash
# Build the production app to the dist/ directory:
bin/ember build --environment production

# Create the zip file of the contents of the dist directory:
cd dist
rm ../wrap/phonegap-build-source-app.zip
zip -r ../wrap/phonegap-build-source-app.zip .
```

There should now be a zip file at this location inside your Rails app:

```
# Inside my-rails-app/ directory, check zip file exists here:
client/wrap/phonegap-build-source-app.zip
```

Log on to PhoneGap Build, upload this latest zip file (at time of writing this is done by clicking the "Update code" button), and wait for the platform build for your test device to complete.

Once the platform build is complete, download the resulting distribution from PhoneGap Build and install it on your test device as you have done previously, and check the app runs successfully.


## How to deploy an Ember-Rails app to Heroku

We're going to shortly deploy your app to Heroku. This will be the production environment.


### Hiding `Procfile` from Heroku

The `Procfile` we use to control our development environment processes is also used by Heroku if it is present. 

The processes we want to run in production are *not* the same as our development environment processes, so we need to make sure Heroku doesn't try to run our `Procfile`.

To stop Heroku from trying to use our `Procfile`, rename it to `Procfile.development`:

```bash
# Inside your-rails-app/ dir, rename Procfile to Procfile.development:
mv Procfile Procfile.development
```

Now Heroku won't find a `Procfile`, but neither will `foreman` when we next try to run `foreman s` (try it and you should see an error message like `Procfile does not exist`). 

To fix this, you can remember to pass the `-f Procfile.development` option to `foreman s`, or you can create a `bin/serve` script to remember this for you. 

Create a new executable file at `my-rails-app/bin/serve`:

```bash
# Inside your-rails-app/ dir:
touch bin/serve

# Make script executable:
chmod +x bin/serve
```
Save the following lines to the `bin/serve` file:

```bash
#!/usr/bin/env sh

echo "Usage"
echo "-----"
echo "Run all: bin/serve"
echo "Without phonegap: bin/serve all=1,phonegap=0 or bin/serve rails=1,ember=1"
echo "Without rails: bin/serve all=1,rails=0"
echo "Ember only: bin/serve ember"
echo ""

# Forward args to foreman command with "$@"
foreman start -f Procfile.development "$@"
```

From now on, to start your development processes, just run the new script:

```bash
# Inside your-rails-app/ dir:
bin/serve
```

Update any `foreman s` instructions in the `README` to refer to `bin/serve` instead. From now on use `bin/serve` instead of `foreman s`.

When Heroku doesn't find a `Procfile`, it falls back to using the default WEBrick server used by `rails s` which is fine while we're building our app.

Once you have an app on Heroku that you want to share with more users, consider moving away from WEBrick. Using a different server on Heroku will involve adding a new `Procfile`. When that time comes, read [Heroku's overview of WEBrick](https://devcenter.heroku.com/articles/ruby-default-web-server) for guidance and links on how to setup an alternative, recommended server.


### Join Heroku

If you're not already signed up for Heroku, sign up and install the Heroku toolbelt.

TODO: Expand these instructions, link to Heroku and toolbelt install how-to.


### Heroku buildpacks

Heroku is a great way to host your Rails apps. It just works out-of-the-box, which can sometimes feel a little mysterious.

We're going to peak behind the curtain on this mystery to help us build a working, repeatable, deployment process that relies on both Ruby **and** Node.js.

When you deploy to Heroku, it looks at the files inside your app, and takes an educated guess at what programming language and environment is needed to run your application.

In the case of Rails apps, it guesses you need a Ruby environment, and sets this up for you using the "Ruby buildpack". 

A buildpack is a collection of scripts that setup a Heroku server by installing software specified in the buildpack. For example, the Ruby buildpack installs Ruby on any Heroku server it is used on.

Heroku has individual buildpacks to setup environments for many programming languages, including Ruby, Python, PHP, Java, and most importantly to us, JavaScript/Node.js.

### Heroku's Multi Buildpack

Our Rails-Ember app needs a JavaScript environment to build the Ember assets at deploy time, **and** it needs a Ruby environment to run the Rails app at runtime. On Heroku, this means we need two buildpacks, the Node.js buildpack, and the Ruby buildpack.

When an app running on Heroku needs multiple buildpacks, then its time to use the multi buildpack.

The multi buildpack lets you specify all the buildpacks you want installed for your app. Multi buildpack installs all of the buildpacks specified in a file named `.buildpacks`, which you're going to add to your app's root directory.

Create a `my-rails-app/.buildpacks` file and save it with these contents, which specify the GitHub URLs for the Node.js and Ruby buildpacks:

```
https://github.com/heroku/heroku-buildpack-nodejs
https://github.com/heroku/heroku-buildpack-ruby
```

These two buildpacks will be installed in the order specified in `.buildpacks` when we deploy our app to Heroku.

### Create a Heroku app

Next we're going to create a new Heroku app to use as the production environment. Run the following command, optionally changing the name `dans-todos` to the app name you want:

```bash
# Inside my-rails-app/ dir:
#
# Create a new Heroku app at dans-todos.herokuapp.com, and
# use the multi-buildpack:
heroku create dans-todos --buildpack https://github.com/heroku/heroku-buildpack-multi
```

**Only** if you forgot to include the `--buildpack` option with `heroku create` above, **or** you are converting an existing Heroku app to use the multi-buildpack, then run this command to set the app's buildpack:

```bash
# Inside my-rails-app/ dir
#
# **Only** run if you forgot the --buildpack option above or are converting 
# an existing app:
heroku buildpacks:set https://github.com/heroku/heroku-buildpack-multi
```

---

*INSTRUCTIONS FOR DAN START*

Update these options in these files to use the new `<APP NAME>.herokuapp.com` URL:

- `config.action_mailer.default_url_options` in `config/environments/production.rb`
- `config.mailer_sender` in `config/initializers/devise.rb`

Create a new `config/application.yml` file with these options, replacing the values:

```
production:
  SENDGRID_PASSWORD: PLEASE_SET_SENDGRID_PASSWORD
  SENDGRID_USERNAME: PLEASE_SET_SENDGRID_USERNAME
  SECRET_KEY_BASE: PLEASE_SET_SECRET_KEY_BASE (generate with 'bin/rake secret')
```

and set the config on Heroku with:

```bash
figaro heroku:set --environment production
```

*INSTRUCTIONS FOR DAN END*

---

### Prepare for Node.js Buildpack

The Node.js buildpack is the first buildpack that will run on deploying to Heroku. There are a few things we need to alter to make our app work successfully with the Node.js buildpack.

By *default*, at deploy time, the Node.js buildpack runs `npm install` and installs any dependencies defined in `dependencies` in `package.json`. However, the dependencies our app needs to build are defined in `devDependencies` (not `dependencies`) in `package.json`. `devDependencies` will *not* be installed unless we set `NPM_CONFIG_PRODUCTION` to false, which you should do now:

```
# Inside my-rails-app/ directory:

# Even though this Heroku app is our production environment, set
# NPM_CONFIG_PRODUCTION to false. There are no downsides to this, it
# makes Heroku install the devDependencies in package.json:
heroku config:set NPM_CONFIG_PRODUCTION=false

# Check NPM_CONFIG_PRODUCTION is now false. This should print false:
heroku config:get NPM_CONFIG_PRODUCTION
```

#### Edit `package.json`

`package.json` contains more than just our Ember app's development dependencies. Open `package.json` and see it contains a `scripts` object. In `scripts` you can specify commands to be runnable with `npm run ...`.

Currently your `scripts` object probably contains `start`, `build`, and `test` entries. These can all be run from the command line (don't bother running them at the moment):

```bash
# Example on how to run scripts defined in package.json:
npm run start # Performs command specified by scripts > start
npm run build # Performs command specified by scripts > build
npm run test  # Performs command specified by scripts > test
```

Delete the following line from the `scripts` configuration:

```
    "start": "ember server",
```

(If we left this `start` script in, we would get a problem on Heroku, as the buildpack tries to create an incorrect `Procfile` on deployment based on the content of any `scripts.start` entry in `package.json`.)

Edit the `build` and `start` scripts in `package.json` so they use the `bin/ember` script created earlier:

```
    "build": "bin/ember build",
    "test": "bin/ember test",
```

After Heroku runs `npm install` at deploy time, it will run the `postinstall` scripts entry in `package.json` if it is defined.

Define a `postinstall` scripts entry in `package.json` to install the Bower dependencies *and* build the Ember application. Add this line inside the `scripts` object:

```
    "postinstall": "bower install && bin/ember build --environment ${DEPLOY:-development}"
```

(`${DEPLOY:-development}` will evaluate to `production` on Heroku so the Ember build will be correctly done with the `production` environment configuration).

The npm and Bower dependencies installed in your Heroku environment may take a few minutes. This time cost is inevitable the first time you deploy and these dependencies are installed.

To speed up subsequent deployments, you can tell Heroku to cache these dependencies by specifying the `cacheDirectories` option in `package.json`. Heroku will cache the given directories between deployments. 

Lets set it up so Heroku will cache the directories where the npm and Bower dependencies are installed. Edit `package.json` so this `cacheDirectories` option is specified below the existing `scripts` option:

```
  ...
  "cacheDirectories": [
    "node_modules",
    "bower_components"
  ],
  ...
```

That's all the preparations done for the Node.js buildpack. Commit your changes to your repository.

### Prepare for Ruby Buildpack

At deployment, the Ruby buildpack runs immediately after the Node.js buildpack and will configure our production environment so it can run our Rails app. Compared to the preparations we did for the Node.js buildpack, there's very little we need to do for the Ruby buildpack.

Ensure the `Gemfile` includes the `rails_12factor` gem in the `:production` environment:

```ruby
gem "rails_12factor", group: :production
```

The `rails_12factor` ensures your Rails app can serve static files and that your app's logging is performed in the Heroku-recommended way. For more information see the [`rails_12factor` README](https://github.com/heroku/rails_12factor).

### First Deploy!

Your app is now ready to be deployed as an Ember-Rails app to your production environment on Heroku, start the deployment and try to read and review the output as it is generated, it'll give you an overview of the steps that are happening at deployment time (being familiar with this will be useful):

```bash
# Inside your-rails-app/ directory:

# Commit all remaining changes to the repo, and push them to GitHub.

# Start the deployment to Heroku, may take a few minutes:
git push heroku master
```

Here's an overview of what happens during deployment to Heroku:

- A copy of your latest code (from master) is sent to Heroku
- The multi buildpack starts:
  - The Node.js buildpack starts:
    - `package.json` `devDependencies` installed to `node_modules/`
    - `postinstall` command from `package.json` is run:
      - Bower dependencies are installed to `bower_components/`
      - Ember `production` application is built to `client/dist/`
    - npm and Bower dependencies directories are cached for use in later deployments
  - The Ruby buildpack starts:
    - Gems required for production are installed
    - Rails server is started

Once the deployment completes, visit your application in your browser:

```bash
# In your-rails-app/ directory:

# Opens URL for your app in web browser:
heroku open
```

In the browser, check you see the Ember app (there may be a delay while the Rails app starts).


### Second Deploy!

Its a good idea to check that our deployment process is repeatable and reliable. We'll make a small change to the app, redeploy, and check the change is visible.

Change the heading text in `client/app/templates/application.hbs` to something very different from the current heading. Save the changes, push them to GitHub, then deploy:

```bash
git push heroku master
```

Once deployment has completed, open the browser and refresh your app's production URL. Check you see the changes to the heading.


### Coming Next...

We'll start building out the Ember app to make use of the backend API (served by Rails) to produce a full featured todo application that runs as a web app in the browser and as a native app on smartphones and tablets.


---

* EXTRA INSTRUCTION FOR DAN START *

Update `bin/serve` to this and review comments. No need to run phonegap most of the time:

```bash
#!/usr/bin/env sh

echo "Usage"
echo "-----"
echo "Run all: bin/serve"
echo "Without phonegap: bin/serve all=1,phonegap=0 or bin/serve rails=1,ember=1"
echo "Without rails: bin/serve all=1,rails=0"
echo "Ember only: bin/serve ember"
echo ""

# Forward args to foreman command with "$@"
foreman start -f Procfile.development "$@"
```

* EXTRA INSTRUCTION FOR DAN END *

---


## User Registration

Its time to start building the first feature for the app, user registration. We'll do this using Behaviour Driven Development.

### Preparing for testing

There's a few tweaks to perform on our testing environment.

Our testing is going to need to be able to check emails sent by our application, for example the registration confirmation email. Use the email_spec gem for this as it provides a good selection of understandable matchers and helper methods. Follow instructions here to setup email_spec: https://github.com/eliotsykes/rspec-rails-examples/blob/master/spec/support/email_spec.rb

Set `config.action_mailer.default_url_options` in `config/environment/test.rb` so URLs in emails can be generated with a host, and not raise an error. I recommend putting the config below any existing `config.action_mailer...` configuration you have in `config/environment/test.rb`:

```ruby
  ...
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  ...
```

Comment out the lines within the `test` environment configuration in `client/config/environment.js` to be like this:

```javascript
if (environment === 'test') {
    // Testem prefers this...
    // ENV.baseURL = '/';
    // ENV.locationType = 'none';

    // keep test console output quieter
    // ENV.APP.LOG_ACTIVE_GENERATION = false;
    // ENV.APP.LOG_VIEW_LOOKUPS = false;

    // ENV.APP.rootElement = '#ember-testing';
  }
```

This will enable our Rails tests to run in an environment that is more consistent with the development and production environments (nb. this test environment config may be brought back later).

RSpec's documentation formatter gives more detailed feedback than the default formatter, in `.rspec`, add this line if its not present:

```
--format documentation
```

Write `spec/support/ember_builder.rb` to build the Ember test environment once for each suite run:

```ruby
class EmberBuilder
  include Singleton

  def initialize
    @build_count = 0
  end

  def build_once
    build if @build_count == 0
  end

  def build
    puts "----------------------------------------------"
    puts "Building Ember test environment..."
    system "bin/ember build --environment=test"
    puts "...completed building Ember test environment"
    puts "----------------------------------------------"
    @build_count += 1
  end

  def self.build_once
    instance.build_once
  end
end

RSpec.configure do |config|

  config.before(:each, type: :feature) do
    EmberBuilder.build_once
  end

end
```

Setup `spec/support/database_cleaner.rb` to work with Capybara JavaScript-capable drivers. Copy from https://raw.githubusercontent.com/eliotsykes/rspec-rails-examples/master/spec/support/database_cleaner.rb

Expand `devise_for` in our routes to be explicit about the Devise controllers it uses, we're going to slowly remove our dependency on Devise's built-in controllers. Edit `devise_for` line in `config/routes.rb` to be:

```ruby
devise_for :users, only: [:sessions, :passwords, :registrations, :confirmations]
```

### BDD: Writing and passing user registration spec

Write the registration feature using Behaviour Driven Development. Here's the spec first, `spec/features/user_registration_spec.rb`:

```ruby
require 'rails_helper'

feature "User registration", type: :feature, js: true do
  
  scenario "successful with valid details" do
    visit root_path

    click_link "Register"

    expect(page).to have_title("Please register")
    expect(page).to have_css(:h1, text: /\ALet.s get you signed up.\z/)

    fill_in "Enter your email", with: "clark@dailyplanet.metropolis"
    fill_in "Enter new password", with: "im superman"
    fill_in "Re-enter password", with: "im superman"
    click_button "Create your account"

    expect(page).to have_title("Please confirm")
    expect(page).to have_text("Please check your inbox and click the link to confirm your account.")
    
    open_email "clark@dailyplanet.metropolis", subject: "Confirm your account"
    click_first_link_in_email
    
    expect(page).to have_title("Sign In")
    expect(page).to have_text("Your account has been confirmed, thank you!")

    fill_in "Enter your email", with: "clark@dailyplanet.metropolis"
    fill_in "Enter your password", with: "im superman"
    click_button "Sign In"

    expect(page).to have_text("You are signed in")
    expect(page).to have_text("Hello clark@dailyplanet.metropolis")
  end

end
```

**TODO: Walkthrough from here step-by-step and check each failure happens as stated and update the rspec output. The above spec has been updated since the failures were written below.**

Run spec:

```bash
$ bin/rspec spec/features/user_registration_spec.rb 
```

Here's the first test failure you'll encounter:

```
  1) User registration successful with valid details
     Failure/Error: click_link "Register"
     Capybara::ElementNotFound:
       Unable to find link "Register"
```

There is no "Register" link on the root page of the app. 

Remove `:registrations` from the `devise_for` `only:` option in `config/routes.rb`. This will stop Devise from generating registration routes for the app. You're going to take control of the registration routes from now on.

Open `client/app/templates/application.hbs` and replace the contents with:

```html
<nav>
{{#link-to 'index'}}Home{{/link-to}}
{{#link-to 'user.new'}}Register{{/link-to}}
</nav>

{{outlet}}
```

Here you're using the Ember [`link-to`](http://emberjs.com/api/classes/Ember.Handlebars.helpers.html#method_link-to) helper to build navigation links to the home (`index`) and user registration (`user.new`) pages. Note the registration page doesn't exist yet, you'll get to that shortly.

The `'index'` and `'user.new'` arguments passed to `{{#link-to '...'}}` in `application.hbs` are the names of Ember routes. Soon you're going to use an Ember generator to generate the `user.new` route. First lets talk about Ember "pods" briefly.


#### Ember Pods

To help organize an application as it grows, Ember introduced the "pod" concept, and for now what you should know about a pod is it a loosely defined way for grouping all of the files related to a particular type of resource within a subdirectory.

Think of a pod similarly to how you think of `resources` routes and models in Rails. For example, if we had a "comment" resource or model, we might have a corresponding "comment" pod that would be at the subdirectory `client/app/pods/comment`. This `client/app/pods/comment` pod would hold all of the Ember JavaScript files that are related to viewing and manipulating comments within the Ember application.

Once you've finished building this app, your `client/` directory structure will eventually look like this, and pay attention to the subdirectories within `client/pods/`:

**TODO: Diagram showing eventual/final directory tree of client/pods**

For user registrations, the resource is "user", and so the name of our pod is going to be "user".

So our pods are generated in the `client/app/pods/` directory, add the `podModulePrefix` configuration line to the existing `ENV` object in `client/config/environment.js`:

```javascript
  var ENV = {
    modulePrefix: 'todos',
    podModulePrefix: 'todos/pods',
    ...
  }
```

The `podModulePrefix` always has a value that is of the format `module_prefix_goes_here/name_of_directory_to_store_pods`, so ensure the `module_prefix_goes_here` part matches the value you have set as `ENV.modulePrefix` in `client/config/environment.js`.

Depending on your version of Ember, your `client/app/app.js` *may* be missing a critical line for enabling pods. Ensure `client/app/app.js` has a section like below, and add the `podModulePrefix: config.podModulePrefix,` line if it is missing:

```javascript
App = Ember.Application.extend({
  modulePrefix: config.modulePrefix,
  podModulePrefix: config.podModulePrefix,
  Resolver: Resolver
});
```

The app is now ready to start using pods with Ember's generate command.


#### Ember Route Generation

Run Ember's generate command to generate a route for registering new users:

```bash
# Inside your-rails-app/ directory:

# The --pod flag tells the command to generate files in the pods directory. Use
# the --pod flag with all ember generate commands:
bin/ember generate route user/new --pod
```

This will generate the following output and files inside the user pod:

```
installing
  create app/pods/user/new/route.js
  create app/pods/user/new/template.hbs
installing
  create tests/unit/pods/user/new/route-test.js
```

*TODO: Discuss Ember's JS test files, for now rely on Ruby specs.*

Next change the `Router.map(...);` call in `client/app/router.js` so it looks like this:

```javascript
...
Router.map(function() {
  // Configure 'user.new' route to serve it at URL path ending '/register':
  this.route('user.new', { path: '/register' });
});
...
```

Run the spec again, and it'll get past the step to click the Register link this time.

The next spec failure you'll encounter:

```
  1) User registration successful with valid details
     Failure/Error: expect(page).to have_title("Please register")
       expected "Todos" to include "Please register"
```

When going to the new user page, the `<title>` element in the `<head>` isn't set to "Please register".

We're going to write an Ember helper named `page-title` that will set the `<title>`.

#### Ember Helpers

Ember helpers are like Rails helpers that you use for providing helper methods to the view templates.

Generate the `page-title` helper:

```bash
bin/ember generate helper page-title --pod
```

This will create the following output and files:

```
installing
  create app/helpers/page-title.js
installing
  create tests/unit/helpers/page-title-test.js
```

Edit the existing `pageTitle` function in `app/helpers/page-title.js` to set the current title:

```javascript
...
export function pageTitle(params) {
  var newTitle = params[0];
  document.title = newTitle;
}
...
```

To use the `page-title` helper on the registration page, open `client/app/pods/user/new/template.hbs` and add this as its first line:

```
{{page-title "Please register"}}
```

Run the spec again:

```bash
bin/rspec spec/features/user_registration_spec.rb
```

The title expectation ought to pass. Here's the next failure you'll see:

```
  1) User registration successful with valid details
     Failure/Error: fill_in "Email", with: "clark@dailyplanet.metropolis"
     Capybara::ElementNotFound:
       Unable to find field "Email"
```

There's no email input field. We'll fix that in the following sections.


#### Ember Model for User

The registration form is going to be backed by a `User` model. Models in Ember are usually the client-side version of some of the models you'll create on the server-side in the `your-rails-app/app/models` directory.

The first Ember model you'll use is for `User`. The `User` model is going to back the registration form you're going to write shortly.

Perform the following command to generate a `User` model, its syntax may be familiar if you're used to using `rails generate model ...` to generate server-side models:

```bash
# In your-rails-app/ directory:
bin/ember generate model user email:string password:string passwordConfirmation:string --pod
```

The command will produce the following output:

```
installing
  create app/pods/user/model.js
installing
  create tests/unit/pods/user/model-test.js
```

The `User` model is generated in the user pod at `client/app/pods/user/model.js`. Open up the file and read through it to increase your familiarity with Ember models.

Next you're going to create an Ember component to display and control the registration form.

#### Ember Components

Say you're working on an app that needs an input credit card number field that formats credit card numbers by displaying spaces to the user between every four digits and for the border to turn green once a valid credit card number has been entered. (TODO: Insert sketch image of a working credit card input) You could write this as an Ember component.

Ember components allow you to define HTML *and* JavaScript behaviour that work in unison to perform a specific function. Writing Ember components is akin to being able to write your own HTML elements. Imagine if you could write your own form controls like `<select>` with autocomplete behaviour specially tailored to your application's needs. That's the sort of thing that Ember components can be used for.

All of these could be Ember components:

- Credit card number input field
- Navigation breadcrumb widget to show where a user is in the site hierarchy, e.g. "Home > Products > Bestsellers"
- Vote Up/Down button
- Password input field with corresponding password-strength indicator
- Entire forms, which is what you're about to make...

#### Registration Form Component

The Ember component you're about to write is going to be used to display the user registration `<form>` and manage its AJAX communication with the server.

The name of this component will be `user-form`. Generate it with this command:

```bash
bin/ember generate component user-form --pod
```

You'll see this output:

```
installing
  create app/pods/components/user-form/component.js
  create app/pods/components/user-form/template.hbs
installing
  create tests/unit/pods/components/user-form/component-test.js
```

Notice that the component files `component.js` (for the component's JavaScript behaviour) and `template.hbs` (for the components view) were generated in the `components/user-form` pod.

Edit `client/app/pods/components/user-form/template.hbs`, to be:

```html
<form {{action "create" on="submit"}}>
  <label for="email">Enter your email</label>
  {{input id="email" type="email" required="true" value=user.email}}

  <label for="password">Enter new password</label>
  {{input id="password" type="password" required="true" value=user.password}}

  <label for="password_confirmation">Re-enter password</label>
  {{input id="password_confirmation" type="password" required="true" value=user.passwordConfirmation}}

  <button type="submit">Create your account &rarr;</button>

  <footer>Already have an account? <a href="javascript:void(0);">Sign in</a></footer>
</form>
```

Review the above code and note:

- In the opening `<form>` tag, the `create` `action` will be performed when the form is `submit`ted.
- The three `{{input ...}}` fields: 
  * The 1st input is for the `user.email` model attribute
  * The 2nd input is for the `user.password` model attribute
  * The final input is for the `user.passwordConfirmation` model attribute.

Ember's `{{input ...}}` helper takes many more options for customization than those shown above. I recommend you read about the [`input` helper in the official API docs](http://emberjs.com/api/classes/Ember.Handlebars.helpers.html#method_input).

Next make use of the `{{user-form}}` component in our registration view template. Update `client/app/pods/user/new/template.hbs` to have the contents:

```html
{{page-title "Please register"}}

<h1>Let&rsquo;s get you signed&nbsp;up&hellip;</h1>

{{user-form}}

{{outlet}}
```

Edit `client/app/pods/components/user-form/component.js` to contain:

```javascript
import Ember from 'ember';

export default Ember.Component.extend({
  init: function() {
    // Call the parent init function:
    this._super.apply(this, arguments);

    // Set up a user to use in the template. Allows user.email, user.password,
    // etc. to be used in input helpers like: {{input value=user.email}}
    this.set('user', this.get('store').createRecord('user'));
  },
  actions: {
    // create() is called when form is submitted
    create: function() {
      // Get user model object from component. It will be auto-populated with 
      // input values from the form:
      var user = this.get('user');

      // Register/save the user via an AJAX request to the server API:
      user.save()
        .then(function { console.log("User saved!"); })
        .catch(
          function(reason) { window.alert("Oops, user not saved! "  + reason); }
        );
    }
  }
});
```

In the `user-form` javascript, there is a call to `this.get('store').createRecord('user')` which is used to create a blank `User` object to back the user form. `this.get('store')` is an object provided by the Ember Data library. Ember Data helps to perform CRUD operations for models, and you can think of it being a bit like Rails' ActiveRecord gem. At the time of writing, Ember Data's `store` is not available to components automatically. To make it available, we're going to need to write an initializer.

#### Ember Initializers

Ember initializers can be used to help setup your Ember application when its first loaded. You can think of them as being similar to Rails' initializers.

Ember initializers are often used to make common objects available directly inside components. The initializers do this by "injecting" specified objects into other objects. (You may have heard this ability to inject objects into other objects being described as "dependency injection").

For example, your Ember app might eventually have JavaScript objects representing the `currentUser`, `search`, or `notifications`. Using an initializer, you can inject these objects (and any other objects you can think of) into the Ember components you write. 

Generate an initializer to inject the Ember Data `store` into all components:

```bash
bin/ember generate initializer component-store-injector
```

This is the output you'll see when generating the initializer:

```
installing
  create app/initializers/component-store-injector.js
installing
  create tests/unit/initializers/component-store-injector-test.js
```

Save `client/app/initializers/component-store-injector.js` with these contents:

```javascript
export function initialize(container, application) {
  // Injects all Ember components with a store object:
  application.inject('component', 'store', 'store:main');
}

export default {
  name: 'component-store-injector',
  initialize: initialize
};
```

This initializer makes the `store` object available in the `user-form` component, meaning the `this.get('store').createRecord('user')` call in the component will now work.


#### API Design and Ember's RESTAdapter

To avoid expending excessive brain cycles on API design decisions, the user API you'll build here is going to behave very closely to [what Ember's RESTAdapter expects by default](http://guides.emberjs.com/v1.11.0/models/the-rest-adapter/).

Ember's RESTAdapter is used to communicate with the server for persisting model data. When you make a call like `this.get('store').createRecord('user')`, the RESTAdapter will be used by `this.get('store')` behind-the-scenes by default.

The `RESTAdapter` expects your JSON API to behave conventionally in terms of the way your JSON data is structured, and the way your API URLs are specified. These conventions can be overridden through configuration, though we will try to keep the custom configuration to a minimum.

Re-run the feature spec:

```bash
bin/rspec spec/features/user_registration_spec.rb
```

You ought to see the failure:

```
  1) User registration successful with valid details
     Failure/Error: Unable to find matching line from backtrace
     ActionController::RoutingError:
       No route matches [POST] "/users"
```

There is no server-side route with the path `/users`. The failure is happening after the registration form has been filled in, once the register button to submit the form is clicked.

By default, Ember's RESTAdapter is `POST`-ing the new user registration data to an API at the URL `/users`, via AJAX, thanks to the `user.save()` call in the `user-form` component.

Looking at `config/routes.rb`, see that API URLs so far have been prefixed with the `/api/v1` namespace. Let's continue with that and configure Ember to be aware of this.

Generate the application's RESTAdapter:

```bash
bin/ember generate adapter application
```

Expected output and files are:

```
installing
  create app/adapters/application.js
installing
  create tests/unit/adapters/application-test.js
```

Its going to be necessary to configure the RESTAdapter to use the `api/v1` namespace for API requests. Its also going to need to be configured to use the correct host when our app is used as a PhoneGap app.

To support these configuration options, edit `client/app/adapters/application.js` to have these contents:

```javascript
import DS from 'ember-data';

// Make `client/config/environment.js` config available to adapter:
import config from '../config/environment';

export default DS.RESTAdapter.extend({
  namespace: 'api/v1',
  host: config.APP.apiHost
});
```

The `host:` option passed to `DS.RESTAdapter` in `application.js` above makes use of a new config option `apiHost` that you'll need to add to `client/config/environment.js` for the `development` and `production` environments:

```javascript
...

  if (environment === 'development') {
    
    ...

    ENV.APP.apiHost = 'http://localhost:3000'
  }

...

  if (environment === 'production') {
    ENV.APP.apiHost = 'https://YOUR-HEROKU-APP-NAME.herokuapp.com'
  }

...
```

Be sure to use the correct value for `YOUR-HEROKU-APP-NAME`, which you can find by running `heroku info` inside `your-rails-app/` directory at the command line. See the Web URL value it outputs.


#### User API Request Spec

Write a request spec defining how the user create API should behave. Save `spec/requests/user_api_spec.rb` with contents:

```ruby
require 'rails_helper'

RSpec.describe "User API", type: :request do
  
  context "POST create" do
    
    it "registers a user and requests confirmation" do
      
      headers = { "Content-Type": "application/json" }
      parameters = {
        user: {
          email: "jean@xmen.xmansion",
          password: "mutants rule",
          passwordConfirmation: "mutants rule"
        }
      }.to_json
      
      post "/api/v1/users", parameters, headers

      expect(response).to have_http_status(:no_content)
      
      expect(all_emails.size).to eq(1)
      expect(last_email_sent).to be_delivered_to("jean@xmen.xmansion")
      expect(last_email_sent).to have_subject("Confirmation instructions")

      expect(User.count).to eq(1)
      user = User.last
      expect(user.email).to eq("jean@xmen.xmansion")
      expect(user.confirmed?).to be(false)
    end

  end

end
```

---

** INSTRUCTION FOR DAN START **

**Setup email_spec**

Follow instructions here to setup email_spec so that the email spec helpers and matchers are available to the specs: https://github.com/eliotsykes/rspec-rails-examples/blob/master/spec/support/email_spec.rb

Set `config.action_mailer.default_url_options` in `config/environment/test.rb` so URLs in emails can be generated with a host, and not raise an error:

```ruby
  ...
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  ...
```

** INSTRUCTION FOR DAN END **

---

#### API Routing

Run this request spec:

```bash
bin/rspec spec/requests/user_api_spec.rb
```

Here's the first failure you'll see:

```
  1) User API POST create registers a user and requests confirmation
     Failure/Error: post "/api/v1/users", params
     ActionController::RoutingError:
       No route matches [POST] "/api/v1/users"
     # ./spec/requests/user_api_spec.rb:9:in `block (3 levels) in <top (required)>'

Finished in 0.1945 seconds (files took 3.71 seconds to load)
1 example, 1 failure
```

A route is not yet configured for our new JSON API endpoint. Add this to `config/routes.rb`:

```ruby
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create], format: false, defaults: { format: :json }
    end
  end
```

#### API Controller

Re-run the request spec and see next failure:

```
  1) User API POST create registers a user and requests confirmation
     Failure/Error: post "/api/v1/users", params
     ActionController::RoutingError:
       uninitialized constant Api::V1::UsersController
     # ./spec/requests/user_api_spec.rb:9:in `block (3 levels) in <top (required)>'
```

This says it is time to create a new controller. Create file `app/controllers/api/v1/users_controller.rb` with contents:

```ruby
class Api::V1::UsersController < Api::ApiController

  skip_before_action :authenticate, only: :create

  def create
  end

end
```

Re-run the request spec and attend to the next failure:

```
  1) User API POST create registers a user and requests confirmation
     Failure/Error: post "/api/v1/users", parameters, headers
     ActionView::MissingTemplate:
       Missing template api/v1/users/create, api/api/create ...
     # ./spec/requests/user_api_spec.rb:18:in `block (3 levels) in <top (required)>'
```

The empty `Api::V1::UsersController#create` action is looking for a matching template. There's no need for a template for a registration request to a JSON API. You're going to return a successful but empty response if a valid user is registered. An empty and successful response is defined by the ["204 No Content" HTTP status code](http://httpstatus.es/204).

Update the `Api::V1::UsersController#create` action to this so it responds with `204 No Content`:

```ruby
  def create
    head :no_content
  end
```

#### Registration Confirmation Email

Re-run the request spec. Here's the next failure:

```
  1) User API POST create registers a user and requests confirmation
     Failure/Error: expect(all_emails.size).to eq(1)
       
       expected: 1
            got: 0
       
       (compared using ==)
     # ./spec/requests/user_api_spec.rb:22:in `block (3 levels) in <top (required)>'
```

No confirmation request email is being sent yet.

Thanks to the default behaviour of Devise's `:confirmable` module that is setup for `User` already, you just have to create a `User` and this will trigger sending the confirmation request email.

Update the controller to the following:

```ruby
class Api::V1::UsersController < Api::ApiController

  skip_before_action :authenticate, only: :create

  def create
    # Creating a user triggers Devise to send confirmation email:
    User.create!(registration_params)
    head :no_content
  end

  private

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
```

#### Rails and JSON case conventions

Rails and its API-related gems tend to gently nudge you towards using `snake_case` naming conventions in your JSON APIs. This is because Rails (and Ruby) use `snake_case` as a convention for writing Ruby code. However, the output from a JSON API is not Ruby code.

In your JSON APIs, prefer to use the JSON convention of `camelCase` keys as JSON API consumers and clients are likely to find it less taxing to support the JSON `camelCase` convention than the Rails convention of `snake_case` variable names. 

The burden of mapping API key names is more efficiently handled in one place by your app, not in multiple places by each and every client consuming your API in the future. 

Most developers, the majority of whom work outside of the Ruby ecosystem, are likely to expect and hope most RESTful APIs follow JSON `camelCase` naming conventions, and working with your API may make their lives easier if it lives up to this very reasonable expectation.

Thankfully Rails gives us a way to have the two naming conventions live in harmony. We will be able to use the `snake_case` convention throughout our Ruby code, even though the JSON API will be using `camelCase` naming.

To benefit from this harmony, create an initializer at `config/initializers/json_param_key_transform.rb` with these contents:

```ruby
# Transform JSON request param keys from JSON-conventional camelCase to
# Rails-conventional snake_case:
Rails.application.config.middleware.swap(
  ::ActionDispatch::ParamsParser, ::ActionDispatch::ParamsParser,
  ::Mime::JSON => Proc.new { |raw_post|

    # Borrowed from action_dispatch/middleware/params_parser.rb except for
    # data.deep_transform_keys!(&:underscore) :
    data = ::ActiveSupport::JSON.decode(raw_post)
    data = {:_json => data} unless data.is_a?(::Hash)
    data = ::ActionDispatch::Request::Utils.deep_munge(data)

    # Transform camelCase param keys to snake_case:
    data.deep_transform_keys!(&:underscore)

    data.with_indifferent_access
  }
)
```

This now means that in your API controllers you should use `snake_case` keys with the params hash, e.g. `params[:password_confirmation]`, even though the parameter is submitted in the JSON request with the name `passwordConfirmation`.

Re-run the spec and bear witness to the failure:

```
Sorry, no failure!
```

That's right, the request spec should be passing now.











#### Styling CSS in Ember

---

*INSTRUCTION FOR DAN START*

Update these 4 files in your app with the contents of the files at the given links. The code hasn't changed much, is mostly text and HTML changes to support the new CSS that's being added below. Review the changes with `git diff` and let me know any questions you have:

1. [client/app/templates/application.hbs](https://raw.githubusercontent.com/eliotsykes/dan-todo/style-registration-form_example/client/app/templates/application.hbs)
2. [client/app/pods/components/user-form/template.hbs](https://raw.githubusercontent.com/eliotsykes/dan-todo/style-registration-form_example/client/app/pods/components/user-form/template.hbs)
3. [client/app/pods/user/new/template.hbs](https://raw.githubusercontent.com/eliotsykes/dan-todo/style-registration-form_example/client/app/pods/user/new/template.hbs)
4. [spec/features/user_registration_spec.rb](https://raw.githubusercontent.com/eliotsykes/dan-todo/style-registration-form_example/spec/features/user_registration_spec.rb)

*INSTRUCTION FOR DAN END*

---

Now the registration form is viewable, clearly it is not looking great. It's time to add some styling so we feel a little happier, and maybe a little more motivated every time we have to look at it.

When you created your Ember application, it created an empty stylesheet for you at `client/app/styles/app.css`.

Any CSS you add to `client/app/styles/app.css` will be used throughout your Ember application thanks to the following line in `client/app/index.html`:

```html
  <link rel="stylesheet" href="assets/todos.css">
```

Notice how the file referenced in the `href` attribute for the above `<link>` element is *not* named `app.css`. The Ember build process, by default, renames the `app.css` file so its available as `your-app-name.css` inside the `assets/` directory.


#### Preprocessing CSS in Ember


##### Sass

I did plan on using plain CSS for this application by writing it in `app.css`, but as soon as I needed to copy and paste the same, human-unfriendly color hex code more than a couple of times, I was ready to bring in a CSS preprocessor. CSS preprocessors give us the ability to write more maintainable and understandable stylesheets. A preprocessor allows you to hide color codes behind human-friendly, meaningfully-named variables.

For this app, you'll write your stylesheets with the help of the [Sass](http://sass-lang.com/) CSS preprocessor language. Thankfully Ember makes it very easy to start using Sass ([and other CSS preprocessors](http://www.ember-cli.com/#less)) in your application through the use of Ember addons.

Ember addons are NPM library packages that integrate with little or no work into your Ember app to add functionality. There are many addons available that can save you development time and they are worth getting familiar with soon, but not now, we've got work to do.

Install the [ember-cli-sass addon](https://github.com/aexmachina/ember-cli-sass):

```bash
# Inside your-rails-app/ directory:
npm install --save-dev ember-cli-sass
```

Delete the existing stylesheet:

```bash
rm client/app/styles/app.css
```

From now on the stylesheet files are going to use the Sass file extension `.scss`.

Copy over all of the `.scss` files from this [GitHub directory](https://github.com/eliotsykes/dan-todo/tree/style-registration-form_example/client/app/styles) into your `client/app/styles/` directory.

Read through the `client/app/styles/app.scss` file. It contains `@import` statements that will bring in the contents of all your other `.scss` files into the final CSS file when Ember builds your app. If you add any further stylesheets, remember to `@import` them in `app.scss`.


##### Autoprefixer

[Autoprefixer](https://github.com/postcss/autoprefixer) is an invaluable tool used by developers who want to preserve their sanity when building applications with cross-browser support. 

Autoprefixer adds missing vendor prefixed properties for any existing CSS properties that need them, to help make your styles cross-browser friendly. Autoprefixer saves you having to remember to add vendor prefixes yourself for the browsers your application supports. It doesn't free you from cross-browser testing but it does make it less likely you'll run into cross-browser styling issues due to missing vendor prefixes.


There's an Ember addon for Autoprefixer. Install it in your application:

```bash
# Inside your-rails-app/ directory
npm install --save-dev ember-cli-autoprefixer
```

Installing this addon is all you need to do to start using Autoprefixer. There's no other configuration you need to do, your stylesheets from now on will be autoprefixed.

By default, Autoprefixer is configured to add vendor prefixes to support a reasonable amount of older browsers. If you'd like to customize the browsers targeted by Autoprefixer and to find out more, see the [ember-cli-autoprefixer README](https://github.com/kimroen/ember-cli-autoprefixer).


#### Write the body-class helper

To be able to apply the registration form specific styles in `client/app/styles/register.scss`, you'll need to be able to set the CSS class on the `<body>` tag to `register`. 

You're going to write a helper called `body-class` to allow you to write a line of code like this in any view template to set the current body class:

```html
<!-- Call the body-class helper to set <body class="whatever-body-class-you-want"> -->
{{body-class "whatever-body-class-you-want"}}
```

Add a `body-class` line to the top of the user registration template file `client/app/pods/user/new/template.hbs` so the contents of the file are:

```html
{{body-class "register"}}
{{page-title "Please register"}}

<h1>Let&rsquo;s get you signed&nbsp;up&hellip;</h1>

{{user-form}}

{{outlet}}
```

When the user registration page is shown, the body CSS class needs to be set to `register`.

Generate the body-class helper:

```bash
# Inside your-rails-app/ directory:
bin/ember generate helper body-class
```

Open the generated `client/app/helpers/body-class.js` and save the file with these contents:

```javascript
import Ember from 'ember';

export function bodyClass(params) {
  var cssClass = params[0];
  var body = Ember.$('body');
  if (!body.hasClass(cssClass)) {
    body.addClass(cssClass);
  }
}

export function bodyClassReset() {
  var defaultBodyClass = 'ember-application';
  // Remove all body classes except for the default ember-application class.
  Ember.$('body').attr('class', defaultBodyClass);
}

export function modifyRouteModuleForBodyClassHelper() {
  Ember.Route.reopen({
    // deactivate runs when a route is exited. This will reset the body class
    // when a route is exited, so old body classes don't pile up.
    deactivate: bodyClassReset
  });
}

export default Ember.HTMLBars.makeBoundHelper(bodyClass);
```

Add these 2 lines that `import` and call the `modifyRouteModuleForBodyClassHelper` function  to just below the existing imports in `client/app/router.js`:

```
// Existing imports in router.js
...
import { modifyRouteModuleForBodyClassHelper } from './helpers/body-class';

modifyRouteModuleForBodyClassHelper();

// Rest of router.js
...
```

Run `bin/serve`, visit the registration form, which should look like this:

![Styled Registration Form](http://cl.ly/image/2p172x0V232L/Image%202015-06-05%20at%207.26.49%20pm.png)











#### Form Submit & Transitioning Routes

---

*INSTRUCTIONS FOR DAN START*

Replace `spec/features/user_registration_spec.rb` contents with contents from here: 

https://github.com/eliotsykes/dan-todo/blob/form-submit-and-transition-route_example/spec/features/user_registration_spec.rb

`git diff` to review the line that changed in the spec.

Create the `client/app/styles/confirmation.scss` stylesheet file and copy the contents from this file into it:

https://github.com/eliotsykes/dan-todo/blob/form-submit-and-transition-route_example/client/app/styles/confirmation.scss

Add this line to the end of `client/app/styles/app.scss` to import the new stylesheet:

```
@import 'confirmation';
```

*INSTRUCTIONS FOR DAN END*

---


Its that time again - to re-run the feature spec:

```bash
# Inside your-rails-app/ directory:
bin/rspec spec/features/user_registration_spec.rb
```

The failure you'll see will be:

```
  1) User registration successful with valid details
     Failure/Error: expect(page).to have_title("Please confirm")
       expected "Please register" to include "Please confirm"
     # ./spec/features/user_registration_spec.rb:18:in `block (2 levels) in <top (required)>'
```

This failure is happening after the registration form has been successfully submitted. Even though the form is submitted, the page title hasn't updated and the view hasn't changed, the registration form is still shown to the user.

You're going to make this part of the spec pass by taking the user to a confirmation pending page after they submit the registration form.

When a user submits the registration form, we currently don't do anything other than log a `"User saved!"` message to the browser console:

```javascript
  // Taken from client/app/pods/components/user-form/component.js
  user.save().then(
    function success() { console.log("User saved!"); },
    ...
  );
```

What you want to do instead of logging to the console, is to send the user to the page that tells them to go check their inbox for the registration confirmation email.

Create a new route for this confirmation pending page:

```bash
# Inside your-rails-app/ directory:

bin/ember generate route confirmation/pending --pod
```

This will generate the following output and files:

```
installing
  create app/pods/confirmation/pending/route.js
  create app/pods/confirmation/pending/template.hbs
installing
  create tests/unit/pods/confirmation/pending/route-test.js
```

It will also add a new route to your `client/app/router.js` file. The `Router.map ...` section of `client/app/router.js` ought to now look like this:

```javascript
...
Router.map(function() {
  this.route('user.new', { path: '/register' });

  this.route('confirmation', function() {
    this.route('pending');
  });
});
...
```

Ember provides a `transitionTo` function to take the user to a new route. You'll want to use this in the `user-form` component to take the user to the `confirmation.pending` route when they've successfully submitted their registration details. In the `client/app/pods/components/user-form/component.js` file, update the contents to the following:

```javascript
import Ember from 'ember';

export default Ember.Component.extend({
  init: function() {
    // Call the parent init function:
    this._super.apply(this, arguments);

    // Set up a user to use in the template. Allows user.email, user.password,
    // etc. to be used in input helpers like: {{input value=user.email}}
    this.set('user', this.get('store').createRecord('user'));
  },
  actions: {
    // create() is called when form is submitted
    create: function() {
      // Get user model object from component. It will be auto-populated with 
      // input values from the form:
      var user = this.get('user');

      // Use ES6 arrow function => syntax to avoid having to call .bind(this)
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions
      var transitionToConfirmationPending = () => {
        this.get('router').transitionTo('confirmation.pending');
      };

      // Register/save the user via an AJAX request to the server API:
      user.save()
        .then(transitionToConfirmationPending)
        .catch(
          function(reason) { window.alert("Oops, user not saved! "  + reason); }
        );
    }
  }
});
```

Notice the new `transitionToConfirmationPending` function that will be called when the user is successfully saved. This is what will transition to the `confirmation.pending` route.

Also notice the call to `this.get('router')` in the `transitionToConfirmationPending` function. This is a reference to Ember's `Router` object.

At time of writing, the router is not available by default in components. This means that we need to write an initializer that will inject the router into components (you may remember we did something similar before to inject the `store` into components).

Create a router injector initializer:

```bash
bin/ember generate initializer component-router-injector
```

This will output the following files:

```
installing
  create app/initializers/component-router-injector.js
installing
  create tests/unit/initializers/component-router-injector-test.js
```

Edit `client/app/initializers/component-router-injector.js` to have the following contents:

```javascript
export function initialize(container, application) {
  // Injects all Ember components with a router object:
  application.inject('component', 'router', 'router:main');
}

export default {
  name: 'component-router-injector',
  initialize: initialize
};
```

The router will now be available inside components as `this.get('router')`.


Next you'll modify the confirmation pending page template `client/app/pods/confirmation/pending/template.hbs`. You're going to set the body CSS class, the page title, and the body paragraph text to match what is expected in the feature spec. Save the template with these contents:

```html
{{body-class 'confirmation'}}
{{page-title 'Please confirm'}}

<p>
  Please check your inbox, open the email we&rsquo;ve just sent you, and click 
  the link inside it to confirm your new account.
</p>

{{outlet}}
```

Re-run the `user_registration_spec.rb` feature spec and you should see a new error in the test failure output, which we'll fix shortly!


#### Confirm Registration & Login


The most recent test failure you'll have from `user_registration_spec.rb` will look like this:

```
  1) User registration successful with valid details
     Failure/Error: Unable to find matching line from backtrace
     ActionView::Template::Error:
       undefined method `new_user_registration_path'
```

This failure happens in the spec immediately after clicking the link to confirm registration in the "Confirm your account" email. It is due to a view template that is no longer used trying to generate a URL path, `new_user_registration_path` that we deliberately removed earlier when we disabled Devise's default registrations controller in `config/routes.rb`.

To get the spec passing, you're going to build a new page in Ember for users to login. The login page will also show a message telling a user when they've just successfully confirmed their new registration.

Generate a route for logging users in:

```bash
# Inside your-rails-app/ dir:
bin/ember generate route session/new --pod
```

The output and files generated by this command ought to be:

```
installing
  create app/pods/session/new/route.js
  create app/pods/session/new/template.hbs
installing
  create tests/unit/pods/session/new/route-test.js
```

The ember generate command will have also added these lines to `client/app/router.js`:

```javascript
  this.route('session', function() {
    this.route('new');
  });
```

To give the new route a shorter, easier-to-remember path, edit the above lines in `client/app/router.js` so they become:

```javascript
  this.route('session.new', { path: '/login' });
```

Make use of this new route in the `client/app/templates/application.hbs` layout template by adding it inside the existing `<nav>` element using the `link-to` helper:

```html
<nav>
...
{{#link-to 'session.new'}}Sign in{{/link-to}}
</nav>
```

Also use the new route in the `<footer>` of the `user-form` component. Replace the existing "Sign in" link in `client/app/pods/components/user-form/template.hbs`. The relevant line in the template will become:

```html
  <footer>Already have an account? {{#link-to 'session.new'}}Sign in{{/link-to}}</footer>
```

The login and session related Devise-provided Rails routes are no longer needed. You can remove the sessions controller from the Devise routes, edit the `devise_for` section of `config/routes.rb` to the following:

```ruby
  devise_for :users, only: [:passwords, :confirmations] # removed: :registrations, :sessions
```

---

**DAN INSTRUCTIONS START**

- Update `spec/features/user_registration_spec.rb` to be the same as: https://github.com/eliotsykes/dan-todo/blob/confirm-registration_example/spec/features/user_registration_spec.rb

- *Update* scss files from this directory https://github.com/eliotsykes/dan-todo/tree/confirm-registration_example/client/app/styles for these files only:
  + `client/app/styles/_color.scss` 
  + `client/app/styles/app.scss`
  + `client/app/styles/form.scss`
  
- *Add* these 2 new scss files to your app from this directory https://github.com/eliotsykes/dan-todo/tree/confirm-registration_example/client/app/styles 
  + `client/app/styles/login.scss`
  + `client/app/styles/notifier.scss`

**DAN INSTRUCTIONS END**

---

The template file that will show the login page is `client/app/pods/session/new/template.hbs`. Replace its contents with the following incomplete code (it's incomplete as it doesn't yet have the login form, which you'll be creating and adding as an Ember component in another section):

```html
{{body-class "login"}}
{{page-title "Sign In"}}

<h1>Sign In</h1>

{{outlet}}
```

Start the Ember server alone so you can do a quick sanity check to be sure you can see the incomplete sign in page:

```bash
# Inside your-rails-app/ directory:
bin/ember serve
```

Visit the home page at http://localhost:4200/ and click the "Sign in" link, after which you'll just see the words "Sign In" if its working.

Notice how you can run the Ember server for some of your development tasks. You don't always need to run the Rails server if what you're doing is only involving the Ember app. When you do run the Ember server alone, it tends to be a little faster than running the Rails server as it requires less resources. Also note that the Ember server is available on port 4200, not port 3000 (3000 is what you use when you use the Rails server).


##### Redirect to login page after confirmation

Once a newly registered user is successfully confirmed, Devise will try to redirect the user to a route that no longer exists.

You're going to create a new Rails route to the login page you just created, and modify Devise so it'll redirect to this route after a successful confirmation.

Open `config/routes.rb` and add the following route **below** the existing `root ...` line:

```ruby
  get '/' => 'welcome#index', as: :login, defaults: { anchor: "/login" }
```

This route allows you to use Rails URL and path helper functionality to generate the correct URL for the new login page using the Rails helper method `login_path`, which will generate a path that Ember's router will understand: `/#/login`.

To get Devise to redirect to this route after a successful confirmation, write a new controller that subclasses Devise's existing `Devise::ConfirmationsController`. Start a new file at `app/controllers/confirmations_controller.rb` and save it with the contents:

```ruby
class ConfirmationsController < Devise::ConfirmationsController

  protected

  def after_confirmation_path_for(resource_name, resource)
    login_path
  end
  
end
```

`after_confirmation_path_for(...)` is a method Devise provides that you can override to change the URL path to redirect freshly confirmed users to. In the above override, you're redirecting confirmed users to `login_path`.

To get Devise to use your custom `ConfirmationsController` instead of the original, tweak the `devise_for` configuration in `config/routes.rb` to be:

```ruby
  devise_for :users,
    only: [:passwords, :confirmations], # removed: :registrations, :sessions
    controllers: { confirmations: :confirmations }
```


##### Notifier component

Re-run the feature spec:

```bash
bin/rspec spec/features/user_registration_spec.rb
```

The failure you'll see:

```
  1) User registration successful with valid details
     Failure/Error: expect(page).to have_text("Your account has been confirmed, thank you!")
       expected to find text "Your account has been confirmed, thank you!" in "Sign In"
     # ./spec/features/user_registration_spec.rb:25:in `block (2 levels) in <top (required)>'
```

The spec is failing when it expects the login page to notify the user that their account has been confirmed.

To decide when to show this message, you'll use a `?notifications=confirmed` query string parameter in the URL path generated by `ConfirmationsController#after_confirmation_path_for`. When you're finished, the URL path `/#/login?notifications=confirmed` will cause the confirmation successful message to be displayed.

Given this login route in `config/routes.rb`:

```ruby
  get '/' => 'welcome#index', as: :login, defaults: { anchor: "/login" }
```

The following 2 options are available for generating a path that has the `?notifications=confirmed` segment needed:

| Code to generate post-confirmation path    | Generates URL path                 | Visiting `/#/todos` after login      |
|--------------------------------------------|------------------------------------|--------------------------------------|
| `login_path(notifications: :confirmed)`    | `/?notifications=confirmed#/login` | Causes full reload of page           |
| `"#{login_path}?notifications=confirmed"`  | `/#/login?notifications=confirmed` | No full page reload, faster for user |

The second option is the one we will use due to its potential for a slight performance gain. It avoids a full page reload after the user successfully logs in and visits the todos index page (which you'll be building later).

The differences in reload behaviour is thanks to how browsers must handle hash fragment identifiers in the URL. Any URL changes made only to the part after the `#` will *not* trigger a full page reload. URL changes made to the part *before* the `#` *will* trigger a full page reload.

Edit the path returned by `ConfirmationsController#after_confirmation_path_for` in `app/controllers/confirmations_controller.rb`:

```ruby
  def after_confirmation_path_for(resource_name, resource)
    "#{login_path}?notifications=confirmed"
  end
```

Generate a notifier Ember component that will be responsible for showing the user the message. The name is prefixed with an `x-` as (for now at least, may be changing in Ember 2.0) Ember component names need to include a hyphen:

```bash
bin/ember generate component x-notifier --pod
```

This will give the output and files:

```
installing
  create app/pods/components/x-notifier/component.js
  create app/pods/components/x-notifier/template.hbs
installing
  create tests/unit/pods/components/x-notifier/component-test.js
```

In the `client/app/templates/application.hbs` layout template use the new component at the top of the file:

```html
{{x-notifier}}
...
```

The reason `x-notifier` is in the layout template and not the login template is that this component is going to be used throughout the entire application to notify the user with messages about actions that have taken place. The registration confirmation message is just one instance where the notifier is needed, there will be more as you develop the application further.

You can think of `x-notifier` as being similar in purpose to the Rails `flash` object, which is often used to show advisory messages to users.

Edit `client/app/pods/components/x-notifier/template.hbs` to contain the following markup for displaying the notification message:

```html
<div class="notifier" aria-live="polite" role="status">
  Your account has been confirmed, thank you!
  <button {{action "close"}}>Close</button>
</div>
```

Notice the use of the `role='status'` and `aria-live='polite'` attributes to explain the purpose of the owning HTML element. These attributes help improve the accessibility of your application.

Open `client/app/pods/components/x-notifier/component.js` and give it the following contents:

```javascript
import Ember from 'ember';

export default Ember.Component.extend({
  // Ember will hide component when isVisible is false.
  isVisible: false,

  // willInsertElement is a hook provided by Ember that runs before the markup
  // for the component is inserted into the page.
  willInsertElement: function() {
    // Make the component visible if the URL contains 'notifications=confirmed'.
    var currentUrl = this.get('router.location.location.href');
    var showNotifier = currentUrl.indexOf('notifications=confirmed') >= 0;
    this.set('isVisible', showNotifier);
  },
  
  actions: {
    // close action is called when `<button {{action "close"}}>Close</button>`
    // is pressed.
    close: function() {
      this.set('isVisible', false);
    }
  }
});
```

Review the comments in the code above and try to see how the x-notifier's template and JavaScript code work together:

- The component is hidden by default thanks to `isVisible: false` in `component.js`
- The component will be shown only if the URL contains `notifications=confirmed`. `isVisible` is set to `true` to show the component in the view.
- When pressed, the close button in the component will hide the component from view by setting `isVisible` to `false`.

Run up the Ember server to experiment with the component:

```bash
# Starts Ember server on localhost:4200
bin/ember serve
```

Open a new tab in your browser and visit [http://localhost:4200/#/login?notifications=confirmed](http://localhost:4200/#/login?notifications=confirmed).

You should see the notifier component with the registration confirmed message:

![Confirmed Regsitration Notification Screen Test](http://cl.ly/image/1q2n2O2b2s22/Image%202015-06-23%20at%208.40.21%20pm.png)

Test the component disappears from view when the close button is pressed.

Re-run the spec:

```bash
bin/rspec spec/features/user_registration_spec.rb 
```

The next failure you'll see will be about one of the sign in form fields being missing:

```
  1) User registration successful with valid details
     Failure/Error: fill_in "Enter your email", with: "clark@dailyplanet.metropolis"
     Capybara::ElementNotFound:
       Unable to find field "Enter your email"
```


## How login will work

The frontend will show the user a login form with an email input field, a password input field, and a sign in button.

For a successful login the following steps will occur:

1. Non-signed-in user enters their correct email and password
2. User clicks sign in button
3. Ember application asks the backend API for an authentication token for the given email and password
4. The backend API responds with the user's authentication token (i.e. `User#api_key`)
5. Ember application stores the token in the browser. This signfies the user is signed in.
6. Ember application sends the token as a header in subsequent requests to the API


## Session Authentication API

**INSTRUCTIONS FOR DAN START**

The API doesn't yet have a way for a user to give their email and password and receive their API token back in return.

You're going to write the `Api::V1::SessionsController` that will be responsible for authenticating users and responding with tokens.

- Copy `spec/requests/session_api_spec.rb` from https://raw.githubusercontent.com/eliotsykes/dan-todo/sessions-controller_example/spec/requests/session_api_spec.rb
- Copy `app/controllers/api/v1/sessions_controller.rb` from https://raw.githubusercontent.com/eliotsykes/dan-todo/sessions-controller_example/app/controllers/api/v1/sessions_controller.rb
- Update `config/routes.rb` from https://raw.githubusercontent.com/eliotsykes/dan-todo/sessions-controller_example/config/routes.rb (this change adds a new route for the sessions controller and combines a couple of similar routes)

To remove one way of performing a brute force attack on the new sessions controller, a user's account will be locked if the wrong password is entered 10 or more times for the same email address. 

The following changes help add this protection by taking advantage of Devise's existing lockable module. Use `git diff` before committing to review the changes and please ask if you have any questions:

- Update `app/models/user.rb` from https://raw.githubusercontent.com/eliotsykes/dan-todo/sessions-controller_example/app/models/user.rb
- Copy `db/migrate/20150705194250_add_lockable_columns_to_users.rb` from https://raw.githubusercontent.com/eliotsykes/dan-todo/sessions-controller_example/db/migrate/20150705194250_add_lockable_columns_to_users.rb
- Run `rake db:migrate`

In `config/initializers/devise.rb`, uncomment and update these three configs:

```ruby
    ...

    config.lock_strategy = :failed_attempts

    ...

    config.unlock_strategy = :none

    ...

    config.maximum_attempts = 10
```

To provide some of the error responses in the sessions controller, you'll need to define some custom exceptions and configure what Rails should respond with when the application raises these custom exceptions. The custom exceptions and the handling configuration is defined in this one initializer script:

- Copy `config/initializers/rescue_responses.rb` from https://raw.githubusercontent.com/eliotsykes/dan-todo/sessions-controller_example/config/initializers/rescue_responses.rb

To help with testing, add these support files, review their contents, and review how they're used in `spec/requests/session_api_spec.rb`:

- Copy `spec/support/json_helper.rb` from https://raw.githubusercontent.com/eliotsykes/dan-todo/sessions-controller_example/spec/support/json_helper.rb
- Copy `spec/support/error_responses.rb` from https://raw.githubusercontent.com/eliotsykes/dan-todo/sessions-controller_example/spec/support/error_responses.rb


Read through `spec/requests/session_api_spec.rb` for tests that explain the new behaviour introduced by the sessions controller.

Run the new spec and be sure it passes before moving on:

```bash
bin/rspec spec/requests/session_api_spec.rb
```

**INSTRUCTIONS FOR DAN END**


## Login Form Component

Earlier you created a `user-form` component responsible for handling user registration. Now you'll create a `login-form` component responsible for handling signing in. The component will be a form containing an email input field, a password input field, and a login button.

Begin by generating the `login-form` component files:

```bash
# Inside your-rails-app/ directory:
bin/ember generate component login-form --pod
```

The generated files reported in the output will be:

```
installing
  create app/pods/components/login-form/component.js
  create app/pods/components/login-form/template.hbs
installing
  create tests/unit/pods/components/login-form/component-test.js
```

In `client/app/pods/session/new/template.hbs` make use of the new component. Add `{{login-form}}` directly below the `<h1>` heading:

```html
...
<h1>Sign In</h1>

{{login-form}}

{{outlet}}
```

Write the form for the component, save `client/app/pods/components/login-form/template.hbs` with these contents:

```html
<form {{action "authenticate" on="submit"}}>
  <label for="email">Enter your email</label>
  {{input id="email" type="email" required="true" value=credentials.email}}

  <label for="password">Enter your password</label>
  {{input id="password" type="password" required="true" value=credentials.password}}

  <button type="submit">Sign In &rarr;</button>

  <footer>Need a new account? {{#link-to 'user.new'}}Sign up{{/link-to}}</footer>
</form>
```

Notice the opening `<form>` tag references an `authenticate` action that will be called when the form is submitted. This `authenticate` action is yet to be written. 

`authenticate` will need to submit the email and password entered in the form to the Rails app. The Rails app will respond with an API authentication token, and eventually you'll store this token in the browser and use it to authenticate all subsequent requests from the user.

Write the following in `client/app/pods/components/login-form/component.js`:

```javascript
import Ember from 'ember';

export default Ember.Component.extend({
  init: function() {
    // Call the parent init function:
    this._super.apply(this, arguments);

    // Set up a credentials object to use in the template. Allows credentials.email and 
    // credentials.password to be used in input helpers, e.g.:
    // {{input value=credentials.email}}
    this.set('credentials', {});
  },
  actions: {
    // authenticate() is called when form is submitted
    authenticate: function() {
      // Get credentials object from component. It will be auto-populated with 
      // input values from the form:
      var credentials = this.get('credentials');

      // Use ES6 arrow function => syntax to avoid having to call .bind(this)
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions
      var onAuthentication = () => {
        window.alert("You are signed in.");

        // Show the list index when login is successful:
        this.get('router').transitionTo('list.index');
      };

      function onAuthenticationFailed(/*error*/) {
        window.alert("Sorry, we failed to sign you in, please try again.");
      }

      // Temporary insecure auth check to help setup the login flow.
      function veryInsecureAuthenticationSucceeds(credentials) {
        return credentials.email === "a@b.c" && credentials.password === "password";
      }

      if (veryInsecureAuthenticationSucceeds(credentials)) {
        onAuthentication();
      } else {
        onAuthenticationFailed();
      }
    }
  }
});
```

Notice that the above authentication check is using a hard-coded email and password. These hard-coded values are a *temporary* measure to help setup the login flow through the app. You will be removing this shortly. Never deploy code like this to a live production environment. Storing hard-coded sensitive data in JavaScript code that is consumed by the browser (as above) is fundamentally insecure. All of the JavaScript code you are writing is readable by your users so it should not contain any hard-coded sensitive data. No usernames, no passwords, no API tokens.

Also note that the use of `window.alert` in the component is temporary. Later you'll be creating a new Ember service `notifier` to help with displaying alert messages to the user.

Upon successful authentication, the component transitions the user to the `list.index` route.

The `list.index` route will eventually show all of the todo lists belonging to the authenticated user. For now you'll just show a mostly blank page with a "Your Lists" heading at this route.

Create the new route:

```bash
bin/ember generate route list/index --pod
```

This generates the following files:

```
installing
  create app/pods/list/index/route.js
  create app/pods/list/index/template.hbs
installing
  create tests/unit/pods/list/index/route-test.js
```

The generate command should have also modified your `client/app/router.js` file. Check this route has been added to `router.js`:

```javascript
  this.route('list', function() {});
```

Open `client/app/pods/list/index/template.hbs` and save it with these contents:

```html
{{page-title "Your Lists"}}

<h1>Your Lists</h1>

{{outlet}}
```

Now you'll exercise the *deliberately & temporarily* very insecure login flow.

Run the Ember server:

```bash
bin/ember serve
```

Visit the sign in page at [http://localhost:4200/#/login](http://localhost:4200/#/login) and try logging in with incorrect details, such as `a@b.c` for the email and `foo` as the password. When you click the sign in button you ought to get an alert popup with the message "Sorry, we failed to sign you in, please try again". Click OK on the alert popup.

Next, change the password input value from `foo` to `password` (this is the value you hard-coded in the `login-form` component earlier). Click the sign in button. You ought to get an alert popup with the message "You are signed in". Click OK on the alert popup and the page should change to show the "Your Lists" page.


## Notifier Ember Service

To get us to this point, we've relied on `window.alert` to show login success and failure message to the user. `window.alert` isn't a very satisfying solution for showing messages as it doesn't allow us to style the messages. Now you'll write an Ember service to help handle showing these messages. 

Ember services are singletons (i.e. only one instance of the service exists) that allow different parts of the same Ember application instance to communicate with each other.

The notifier service will allow any component to specify a message string to show to the user. Ember services don't render HTML directly in the page. The HTML rendering will be done by the `x-notifier` component you wrote earlier.


## Design the Notifier Service

What is going to make a well designed notifier service? What methods should it provide as an interface to its client objects in our application?

One tactic that helps with designing a new service is to dream up and write the code that would call the service in an ideal world. This can help reveal what a simple, usable interface for the service might be.

First of all let's dream up some ideal code in the `login-form` component to replace `window.alert`.

Open `client/app/pods/components/login-form/component.js` and update the `authenticate` function to the following:

```javascript
    authenticate: function() {
      // Get credentials object from component. It will be auto-populated with 
      // input values from the form:
      var credentials = this.get('credentials');

      // Get the notifier service:
      var notifier = this.get('notifier');

      // Use ES6 arrow function => syntax to avoid having to call .bind(this)
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions
      var onAuthentication = () => {
        notifier.setMessage("You are signed in.");

        // Show the list index when login is successful:
        this.get('router').transitionTo('list.index');
      };

      function onAuthenticationFailed(/*error*/) {
        notifier.setMessage("Sorry, we failed to sign you in, please try again.");
      }

      // Temporary insecure auth check to help setup the login flow.
      function veryInsecureAuthenticationSucceeds(credentials) {
        return credentials.email === "a@b.c" && credentials.password === "password";
      }

      if (veryInsecureAuthenticationSucceeds(credentials)) {
        onAuthentication();
      } else {
        onAuthenticationFailed();
      }
    }
```

Notice we replaced `window.alert` with calls to the imaginary `notifier.setMessage` function.

For now let's assume we're eventually going to be able to figure out how to get the `notifier.setMessage` function to work as this code desires.

Next, we'll dream up the code in the `x-notifier` component that we'd like to see work.

Open `client/app/pods/components/x-notifier/template.hbs` and remove the hard-coded message as we need it to be flexible by making the message variable. Replace it with a call to `{{ notifier.message }}`. Eventually `notifier.message` will get the current message from the notifier service. Here's how the template will look once you've made this change:

```html
<div class="notifier" aria-live="polite" role="status">
  {{ notifier.message }}
  <button {{action "close"}}>Close</button>
</div>
```

Now open up `client/app/pods/components/x-notifier/component.js`. Edit it so it has the following contents, and review all of the changes we've made to use the to-be-written notifier service:

```javascript
import Ember from 'ember';

export default Ember.Component.extend({
  // Ember will hide component when isVisible is false.
  isVisible: Ember.computed.readOnly('notifier.hasMessage'),
  
  actions: {
    // close action is called when `<button {{action "close"}}>Close</button>`
    // is pressed.
    close: function() {
      this.get('notifier').clear();
    }
  }
});
```

Summarizing the changes we made to this file:

- The `x-notifier` component is no longer responsible for inspecting the query string for 'notifications=confirmed'. We're going to move this responsibility to the notifier service.
- The `close` action no longer controls the visibility of the component directly. Instead it calls the notifier's `clear` function which will clear the current message.
- The `isVisible` property is no longer controlled by this component alone. Instead `isViaible` is now an `Ember.computed` property. `Ember.computed` properties are used to determine the value of one property from the result of another property. Computed properties are a powerful, flexible concept that you'll want to dive into deeper later. Here the `isVisible` property for the component will correspond to the value of `hasMessage` on the `notifier` service. In other words, when the notifier has a message, the component will be displayed. When the notifier does not have a message, the component will be hidden.

Given the above idealized code changes, we now have an idea of what a good interface for the notifier service would look like:

- `notifer.setMessage(message)` sets the current notifier message string to show to the user
- `notifier.message` gets the current notifier message
- `notifier.hasMessage()` returns a boolean: `true` if the notifier has a message
- `notifier.clear()` removes the current notifier message

The idealized code also tells us that you're going to need the notifier service available to the `x-notifier` and `login-form` components. To make a service available to a component, it has to be injected by an Ember initializer. You'll write an initializer shortly that will inject the notifier service into all components.

## Write the Notifier Service

Use the Ember service generator:

```bash
# Inside your-rails-app/ directory:
bin/ember generate service notifier
```

This will generate the following output and files:

```
installing
  create app/services/notifier.js
installing
  create tests/unit/services/notifier-test.js
```

Open `client/app/services/notifier.js`. Write the code to fulfil the interface you designed in the previous section:

```javascript
import Ember from 'ember';

export default Ember.Service.extend({
  // init function is a hook provided to Ember Services that you can optionally
  // override. It is run once when the Ember application first loads.
  init: function() {
    this.initMessageFromAnyNotificationKeysInUrl();
  },

  message: '',
  
  // Thanks to computed properties, hasMessage will return true when the 
  // notifier message is not empty:
  hasMessage: Ember.computed.notEmpty('message'),
  
  setMessage: function(message) {
    this.set('message', message);
  },

  clear: function() {
    this.setMessage('');
  },

  initMessageFromAnyNotificationKeysInUrl: function() {
    var currentUrl = this.get('router.location.location.href');
    var hasNotificationKeysInUrl = currentUrl.indexOf('notifications=confirmed') >= 0;
    if (hasNotificationKeysInUrl) {
      this.setMessage('Your account has been confirmed, thank you!');
    }
  }
});
```

Review the code and comments above line-by-line to understand what its doing. Notice in particular the use of a computed property again (for `hasMessage`) and that the URL `notifications=confirmed` detection is now done in this service (previously it was done in the `x-notifier` `component.js`).


## Notifier Initializers

The `login-form` and `x-notifier` components are dependent on the `notifier` service. Generate the initializer that you'll use to inject this dependency:

```bash
bin/ember generate initializer component-notifier-injector
```

The generate command will output these files:

```
installing
  create app/initializers/component-notifier-injector.js
installing
  create tests/unit/initializers/component-notifier-injector-test.js
```

Open `client/app/initializers/component-notifier-injector.js` and modify it so that it injects the notifier service into all components:

```js
export function initialize(container, application) {
  // Injects all Ember components with the notifier service:
  application.inject('component', 'notifier', 'service:notifier');
}

export default {
  name: 'component-notifier-injector',
  initialize: initialize
};
```

Take another look at the `notifier` service you just wrote - open `client/app/services/notifier.js` and see the line that depends on the `router`:

```js
  var currentUrl = this.get('router.location.location.href');
```

The `router` is not available to Ember services, like our `notifier` service, by default. You'll need to inject the `router` dependency otherwise the above line of code will fail. Generate another initializer to take care of this, run:

```bash
bin/ember generate initializer notifier-router-injector
```

This should generate the following:

```
installing
  create app/initializers/notifier-router-injector.js
installing
  create tests/unit/initializers/notifier-router-injector-test.js
```

Put the following injection code into `client/app/initializers/notifier-router-injector.js`:

```js
export function initialize(container, application) {
  // Injects router into the notifier service:
  application.inject('service:notifier', 'router', 'router:main');
}

export default {
  name: 'notifier-router-injector',
  initialize: initialize
};
```

From now on, thanks to this initializer, you'll be able to make use of the `router` within the `notifier` service.

## Feature Spec Check-in

Run the user registration feature spec to see how we're progressing:

```bash
bin/rspec spec/features/user_registration_spec.rb
```

The failure you'll see ought to be:

```
Failures:

  1) User registration successful with valid details
     Failure/Error: expect(page).to have_text("You are signed in")
       expected to find text "You are signed in" in "Sorry, we failed to sign you in, please try again. CLOSE Sign In ENTER YOUR EMAIL ENTER YOUR PASSWORD Sign In → Need a new account? Sign up"
     # ./spec/features/user_registration_spec.rb:31:in `block (2 levels) in <top (required)>'
```

The spec is complaining that the "You are signed in" message was not shown to the user. As the app stands, this is correct, there's nothing hooked up to authenticate a user - yet. Next you'll connect the client-side login form to submit the user's email and password to the sessions controller running server-side.

