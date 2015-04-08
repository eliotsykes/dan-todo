#Blocitoff
A rake automated todo list

To seed:
```
rake db:schema:load
rake db:seed
```

Make an API call using curl:
```
curl -H "X-Api-Key: YOUR-KEY" http://localhost:3000/api/v1/lists.json
```