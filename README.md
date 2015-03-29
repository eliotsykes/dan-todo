#Blocitoff
A rake automated todo list

To seed:
```
rake db:schema:load
rake db:seed
```

Make an API call using curl:
```
curl -H "Authorization: Token token=[your-token-without-brackets]" http://localhost:3000/api/v1/lists
```