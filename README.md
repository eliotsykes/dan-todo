#Blocitoff
A rake automated todo list

To run the app, ensure the foreman gem is installed (`gem install foreman`), and run:

```bash
bin/serve
```

To seed:
```
rake db:schema:load
rake db:seed
```

Make an API call using curl:
```
curl -H "X-Api-Key: YOUR-KEY" http://localhost:3000/api/v1/lists.json
```
To create a list via the api with curl:
```
curl -H "X-Api-Key: TCwrsTTMp8C2H1vIHPNX4wtt" -d "list[title]=Test" http://localhost:3000/api/v1/lists
```
To delete one:
```
curl -H "X-Api-Key: TCwrsTTMp8C2H1vIHPNX4wtt" -X DELETE http://localhost:3000/api/v1/lists/[:id]
```


# Developer Setup

- `nvm use` to use correct node version specified in `.nvmrc` (should be same as in `package.json`)
- `npm install` (automatically triggers `bower install` via postinstall script in `package.json` `engines` option)
- Specify ruby version in `.ruby-version`
- `bundle install --without production`


## Ember Upgrades

Follow instructions carefully: https://github.com/ember-cli/ember-cli/releases

# Fresh Heroku Production Environment Setup

- `heroku create choose-your-app-name --buildpack https://github.com/heroku/heroku-buildpack-multi`
- `cp config/application.yml.example config/application.yml` and fill in blanks for production env.
- `bin/figaro heroku:set --environment production`

# Commands to run via `bin/`

- `bin/ember`
- `bin/phonegap`
- `bin/rails`