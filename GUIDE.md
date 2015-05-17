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

By default, your Rails app is configured to serve static files, such as `index.html`, from the `public/` directory. Let's configure it to instead serve files from a directory that the Ember application will be built to.

The Ember application will be built into the `client/dist` directory. This is the directory we want to replace the Rails `public/` directory with. Create a new initializer script at `your-rails-app/config/initializers/public_path.rb` with the following contents:

```ruby
# Set public path to be the Ember-managed client/dist directory:
Rails.application.config.paths["public"] = File.join("client", "dist")
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

Delete `public/index.html`.

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
foreman start -f Procfile.development
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
    `"postinstall": "bower install && bin/ember build --environment ${DEPLOY:-development}"`
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
