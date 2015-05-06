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

Make a new subdirectory, 'client/wrap', of your existing Rails application. This is the directory PhoneGap will perform its work in:

```bash
# Inside my-rails-app/ directory:
mkdir -p client/wrap
```

Create a new PhoneGap app, using `--id` and `--name` options of your choice. For example:

```bash
# Inside my-rails-app/ directory:
phonegap create client/wrap --id "com.appsfromdan.todo" --name "My Todos"
```

This will create a few directories in `client/wrap`, including a `www` directory.

The `www` directory is where PhoneGap expects to find `index.html`. PhoneGap has generated a default `index.html` in that location, but we won't be using that, so we can safely remove it:

```bash
# Inside my-rails-app/ directory:
rm client/wrap/www/index.html
```

Now create a symlink to your `public/index.html`:


```bash
# Inside my-rails-app/ directory:
ln -s ../../../public/index.html client/wrap/www/index.html
```

(Check the symlink is correct by trying to open the `client/wrap/www/index.html` file in an editor).

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

Add these changes and the new `client` directory to version control.

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

# Clear Bower cache:
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
ember init --name todos
```

Once `ember init ...` has completed (it may take a while), it's a good idea to check that the ember app and environment is working okay:

```bash
# Be in the client/ directory:
cd my-rails-app/client

# Run Ember server:
ember s
```

Once the Ember server is up and running, visit [http://localhost:4200/](http://localhost:4200/) in your browser. If everything is working as expected, you should see a page with the message "Welcome to Ember.js".

Stop the Ember server by pressing `Ctrl+C`.

Add the generated Ember app to your git repository.


## Ember at the front, Rails at the back

Its time to get our Ember and Rails apps working together in our development environment.

The Rails app is going to be responsible for delivering the Ember application files to the browser and will handle all API requests.

The Ember app is going to be responsible for the frontend and will run in the browser.

To support this in the development environment, you'll run two processes:

1. `rails server` to serve requests for the API coming from the frontend, *and* to deliver the Ember application files to the browser
2. `ember build` to build your Ember app files into a directory that Rails will serve them from

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
# Inside my-rails-app/ directory:
cd client

# Builds Ember's files to client/dist/ and watches for changes to Ember's files:
ember build --watch
```

`ember build --watch` is going to continue running while we develop. Next, open a new Terminal tab and start the Rails server:

```bash
# In new Terminal tab, inside my-rails-app/ directory

# Start the Rails server:
bin/rails s
```

Once `rails s` is running, visit [http://localhost:3000/](http://localhost:3000/) in your browser. You should see a page with the headline "Welcome to Ember.js". This page is being served by your Rails server. The contents of the page are the Ember app. The file for this page is `client/dist/index.html`.

Let's check that changes you make to the Ember app during development are picked up in the browser.

In your editor, open the Ember template located at `client/app/templates/application.hbs`. It will contain the "Welcome to Ember.js" headline. Change this headline text to "Hello World" and save the file.

In the browser, refresh [http://localhost:3000/](http://localhost:3000/), and you should see the "Hello World" headline, which means congratulations, you've successfully put together a working development workflow.

Stop both the Rails server and Ember build processes with `Ctrl+C` in each terminal tab.

Save the changes we've made to your application to your repository.

### Coming Next...

Next we'll save ourselves time and precious keystrokes by using the Foreman gem to manage the `rails s` and `ember build` commands in our development environment.


## Run multiple processes in one command with Foreman

[Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html) is the simplest way I've encountered to run the multiple processes that advanced Rails applications often need.

In this particular app, we've got two processes that need managing in our development environment: the `ember build --watch` process, and the `rails s` process.

Foreman is a gem that reads and runs the processes you want managed from a `Procfile`. Each line in the `Procfile` contains a name for a process and the command used to start that process. 

Create `my-rails-app/Procfile` with these contents, which defines two named processes, `rails` and `ember`:

```
rails: bin/rails server
ember: cd client && ember build --watch && cd ..
```

In Terminal, install the foreman gem:

```bash
gem install foreman
```

Finally, run the `foreman start` command (or `foreman s` for short) to get Foreman running your `ember` and `rails` processes:

```bash
foreman s
```

Lets check this is working correctly. Visit [http://localhost:3000/](http://localhost:3000/) and check you see the "Hello World" headline from the Ember app.

From now on, you'll be mostly using `foreman s` to run your app while you develop it. The idea is this is simpler to remember and faster to type than if we tried to manage the two `rails` and `ember` processes separately in their own Terminal tabs. If we bring other developers on board it should also make it more straightforward for them to get the app up and running on their machine.

Quit foreman and its managed processes with `Ctrl+C`.

Now might be a good opportunity to briefly document `gem install foreman` and `foreman s` in your application's README.


### Coming Next...

Since introducing Ember into our application, we've got our Rails development environment up and running to work with it successfully and simply thanks to Foreman. 

There's a little more re-organization and re-configuration of our application to do so it'll work everywhere we need it to, including on Heroku and as a PhoneGap app.

