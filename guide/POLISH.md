# Polish

Finishing touches to apply after MVP/first draft.

## Accessibility explainers

Explain accessibility choices in main flow of book as they're taken:

- `role='status'` on `div.notice` with `aria-live='polite'`
- Close button/link includes text, not just X in `div.notice`


## Code conventions

- Use single quotes/double quotes (what's Ember core convention?) consistently.


## Registration form

- Phone-sized wireframes/screengrabs (in phone hardware frame, e.g. iPhone) of registration form we're building, loading screen, confirmation page, in-between states.

- Extra options on input fields from http://emberjs.com/api/classes/Ember.Handlebars.helpers.html#method_input, for example:
  * Disable/read-only fields on submit
  * Validate password length / regex pattern for secure passwords (min/max lengths)
  * Password strength indicator component
  * Client-side inline validation messages
  * Password + Password confirmation component


## Confirm Registration

- Behaviour & test coverage for unknown confirmation token


## Notifier component

- Use component name without hyphen, without `x-` prefix (supported in Ember 2.0 IIRC)
- Alter isVisible to be a computed property or a function that returns showNotifier. Fixed by https://github.com/emberjs/ember.js/pull/11235


## API

- attr_encrypted tokens
- OAuth


## Ember Components Overview/Examples

- Wireframe(s) with Ember component candidates highlighted


## CSS Development Workflow

Determine most lightweight option(s), try not to add further processes (e.g. guard) if a reasonable alternative exists.

- LiveReload with `ember s` or can `ember build` be made to work with livereload
- LiveReload via [rack-livereload](https://github.com/johnbintz/rack-livereload) middleware and `bin/serve`
- Consider skipping livereload in favor of https://github.com/xomaczar/ember-cli-styles-reloader
- Use LiveReload with PhoneGap developer app and with Rails server. Use Ember's LiveReload for both and pass `--no-autoreload` option to `phonegap serve`?
- Ensure there's only one LiveReload server if both phonegap and ember processes are running



## Robust symlinking for NPM, Ember

In bin/ember script, check that all symlinks are as expected and raise warning if not. On Heroku and in development.
Check all symlinks as there are a number of ways they can be accidentally broken:

- `npm install ...` inside `client/` and `bin/ember install ...` overwrites package.json symlink with full file. Now there are 2 package.json files, oops. Check that package.json and client/package.json are identical and/or symlinked in the correct direction.

- node_modules, bower symlinks .gitignore configuration is very sensitive. Easy to break it on production but still have it working in development and test environments. `bin/ember` (npm postinstall) script should detect these, warn if they're not there, and then create them, with error message that nudges to add to git repo.

- Add to instructions: Run `npm install` locally before pushing to Heroku, sanity check that approximation to Heroku deploy works.

- Add to instructions a script that creates the symlinks or checks they're created and stored in repo. If the symlinks are not as expected then Heroku deploy will fail.


## UI response

- FastClick to remove tap delay


## Thorough testing of CSS across browsers


## Lockdown node version

Include instructions for:

- Installing nvm
- Installing specific node version with nvm
- Create `.nvmrc` file containing node version
- Running `nvm use` to set node version (automate this?)
- Specifying node version in `package.json` `engines` option


## bin/npm_setup

- Colorize echo output from npm_setup (and other scripts?)
- Introduce bin/npm_setup the first time an addon is installed. Currently instructions use npm install early on for installing ember-cli-sass and ember-cli-autoprefixer to avoid tackling the package.json-symlink issue.


## bin/ember COMMAND consistency

- Use the expanded bin/ember COMMAND rather than shorthand throughout. E.g. bin/ember generate not bin/ember g.


## application.js route and router.js customizations

Move the body-class helper customization out of router.js and into the application.js route:


Delete this from router.js:
```javascript
...
import { modifyRouteModuleForBodyClassHelper } from './helpers/body-class';

modifyRouteModuleForBodyClassHelper();
...
```

Add this to client/app/routes/application.js (preliminary experiment shows it works):

```javascript
...
import { modifyRouteModuleForBodyClassHelper } from '../helpers/body-class';

modifyRouteModuleForBodyClassHelper();
...
```

Notice the `..` change in the `import` line above.



## Why Ruby for acceptance tests? Why not JS?

See App Store Rails notebook note "Why using Capybara (or other ruby-based) acceptance tests?". TLDR: speed, control, power, DRY. HTTP-based dependent solutions are poor when compared to talking to model layer directly. Remember experiences with HTTP fixtures in Selenium IDE.

This PR also makes some relevant points: https://github.com/jfirebaugh/konacha/pull/60#issuecomment-7790134

+ helps keep amount of new things to learn (for Rails-focused developers) in check.
+ emails can be accessed easily for testing, doesn't need an HTTP layer
+ Avoids test assertions and test data setup being conducted over HTTP and introduce an extra layer in to the testing stack. Avoiding this layer tends to make writing tests quicker.


## Use Ember Simple Auth name consistently

Use either "Ember Simple Auth" or ember-simple-auth. See what the README does https://github.com/simplabs/ember-simple-auth.


## Fix no-gutter styling on confirmation page

Post-registration, the "Please check your inbox, open the email we’ve just sent you, and click the link inside it to confirm your new account." message styling pushes the text up against the browser window. Introduce some spacing on narrow screens. May be happening on other similar pages.


## Choose an Initializer Injector Convention

Research existing conventions. Be consistent with an initializer injector convention, and choose a sensible one. Consider having one of these:

- An injector initializer for each object type that receives the injection (e.g. component-injector.js)
- An injector initializer for each object that is injected, (e.g. store-injector.js, router-injector.js, notifier-injector.js)
- Something else from research


## Ember Notifier Service notice vs alert

- Handle notice and alerts
- Example alert would be login failure (wrong password)
- Example notice would be login success
- Show differing styles (and icon?) for notice vs alert


## Naming notifier component and service

- Rename x-notifier component to noticeboard component?
- Keep notifier service named as notifier?


## Dependency Injection Clarity for Readers

I've started out doing dependency injection using initializers, though I'm not sure this is the clearest method...

On reflection, for at least some cases, it would be clearer for the reader to have the dependency and its injection, documented in code right there in the file its used. For example, it'd be more understandable to inject the `router` inside the notifier service in `client/app/services/notifier.js` rather than having a separate initializer script for that purpose. Perhaps for other dependencies it makes sense to use an initializer, e.g. when the injection would need to happen multiple times, like pretty much always injecting components with the `store`.

[See `Ember.inject.service('notifier')` usage in `routes/application.js`](https://github.com/eliotsykes/dan-todo/pull/26/files#diff-59620bd5cfc481f6b567b969ae335311R9)


## Debugging Nuggets

http://guides.emberjs.com/v1.13.0/understanding-ember/debugging/

## L10n & i18n Overview

Overview of approaches to providing localized versions of app. Technique(s) will need to work for app store apps and web app.


## Ember Artifacts Overview

Include table of Ember artifacts (components, services, routes, etc.) describing what each is, when it should be used, and giving example usage.

Show overview table early on in book then repeat row(s) of it throughout book when introducing an artifact.

| Ember Artifact | Summary       | Examples                         |
|----------------|---------------|----------------------------------|
| Components     | ...           | Password strength indicator, ... |
| Services       | Singleton ... | ...                              |
| ...            |               |                                  |


## Test Environment Speedup

Get EmberBuilder to kick-off `bin/ember build --watch` if its not running or detect when its already running. Fork its process so it continues to run after the tests finish. See if this helps speed up the feature spec runs as the ember app doesn't need building each time.


## Home Screen Design

Incorporate these "Home Screen Spike" changes into the final book: https://github.com/eliotsykes/dan-todo/pull/26 (closed & unmerged pull request)

Use the above CSS and home page design from the very beginning in the final book. The logged-in and logged-out messages should be introduced as soon as possible, in the first time the registration and login specs are introduced, and the first time the related ember artifacts are written (authentication route customizations in routes/application.js, notifier service).


## Animated UI

Improve feel of UI using animations (via liquid-fire?). Candidate animations:

- Notifications via notifier service (when appearing and when closing)
- Switching screens, e.g. home screen -> login/registration
- Lists -> New/Edit List and back


## Running `ember` ought to call `bin/ember` (likewise phonegap, serve & other bin/ scripts?)

Its easy to accidentally run `ember` in the root project/Rails directory which results in files not being created in the `client/` directory (and then the accidental files need cleaning up). Have `bin/ember` or `bin/` be at the start of the PATH. See this for ideas & possibly using direnv project: https://github.com/sstephenson/rbenv/wiki/Understanding-binstubs#adding-project-specific-binstubs-to-path

See if the ember executable provides or can be augmented with a mechanism to check a .ember-cli file in the project root for the ember `client/` directory. The advantage of an Ember CLI supported solution is that the paths output from ember commands would show the correct paths starting with `client/`, e.g. when running an ember generator.

Research this solution to running rails and ember generators from the one `geee` command, maybe something along similar lines for this? Its both a node package and a gem: https://rubygems.org/gems/geee , https://github.com/coleww/g , https://www.npmjs.com/package/geee


## Touch gestures

Introduce hammer.js for touch gestures, such as deleting lists/items by swiping.


## Consider Picnic CSS for good default, classless styles

Avoid DIY CSS? Picnic CSS is classless, allows demonstration markup with minimal clutter and so is less distracting. http://www.picnicss.com/


## Client-Side Validation

Apply `disabled` to Save/Update `<button>`s until model valid.

- https://github.com/dockyard/ember-validations
- https://github.com/maestrooo/ember-cli-html5-validation


## Focused gems à la tiny npm packages

This will reduce side-tracking content in the book. Some potential gems:

### capybara-refresh

`refresh` method used in feature specs

### rspec-json-testing

See `spec/support/json_helper.rb`

### rails-ember-testing

See `spec/support/ember_builder.rb`

### rails-error-testing-helper

See `spec/support/error_responses.rb`

### rails-capybara-extensions

See `spec/support/browser_cache.rb`

### rails-testing-extensions

A gem that configures automatically (or generates config) in place of the majority of files in `spec/support`

### rails-errors-extended / rails-rescue-more

```ruby
# config/initializers/rescue_responses.rb
class UnauthorizedAccess < ActionController::ActionControllerError
end

class UnsupportedMediaType < ActionController::ActionControllerError
end

ActionDispatch::ExceptionWrapper.rescue_responses.merge!(
  'UnauthorizedAccess' => :unauthorized,
  'UnsupportedMediaType' => :unsupported_media_type
)
```

### rails-static-router

See `config/initializers/static_router.rb`

### rails-json-keymaster / rails-param-keymaker

```
# config/initializers/json_param_key_transform.rb
# Transform JSON request param keys from JSON-conventional camelCase to
# Rails-conventional snake_case:
...
```

Obsoleted if json-api-resources gem used?

### rails-public-path

See `config/initializers/public_path.rb`

### Parent gem to wrap these smaller gems?

E.g. rails-api-extensions that just requires all the above small gems as dependencies. Readers will only need to `gem 'rails-api-extensions'` in `Gemfile`.


## JavaScript Debugging Kickstart Chapter

- Write `debugger` to add a breakpoint in your JS.
- `console.log(...)`
- Chrome/Firefox dev tools (enable AJAX logging in Chrome)
- Other tips


## Put Offline Chapter at End

App should work offline. Offline-not-quite-first/offline-last, so as to avoid adding an excess of new stuff at once for developers encountering Ember for the first time.
