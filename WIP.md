Work in progress
----------------

rails: bin/rails server --port ${RAILS_PORT:=3000}
<!-- rails: bundle exec rails server --port ${RAILS_PORT:=3000} -->
ember: cd client && ember build --watch true && cd ..

```bash
cd client && ember build --environment production --output-path dist/pgb && cd -
cd client/dist/pgb && zip -r pgb.zip . && cd -
```
