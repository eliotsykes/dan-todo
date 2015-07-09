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


## Secure by default routes

Assume all routes require login unless explicitly excluded on a per-route basis:

https://github.com/simplabs/ember-simple-auth/issues/578


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
