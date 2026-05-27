### Stack

Ruby 3.4.1, Rails 8.1.3, SQLite >= 2.1 db, Hotwire: turbo and stimulus, ERB views, importmap-rails, propshaft, Jbuilder, Rails 8 solid stack, Docker + Kamal deployment


### Commands

#### Setup
- One shot `bin/setup`
- Without auto-starting the server `bin/setup --skip-server`
- Install Ruby gems `bundle install`
- Create and migrate DB for dev and test `bin/rails db:prepare`
- Load seed data `bin/rails db:seed`
- Run pending migrations `bin/rails db:migrate`
- Drop, recreate, migrate, and seed the deb DB via `bin/rails db:reset`


#### Run
- Start Rails deployment server (Puma) via `bin/dev`. The same can be done via `bin/rails server`
- Rails CLI `bin/rails console`
- SQLite CLI `bin/rails dbconsole`


#### Test
- Run all unit/integration tests `bin/rails test`
- Run system tests `bin/raisl test:system`
- Prepare the test DB, the run unit and system tests `bin/rails db:test:prepare test test:system`
- Run a single test file `bin/rails test test/models/<filename>`


#### Lint
- Style via RuboCop `bin/rubocop`, with Github Actions annotation format `bin/rubocop -f github`
- Static secruity check for Rails vulnerabilities `bin/brakeman`
- Check JS packages for vulnerabilities `bin/importmap audit` 

### Conventions

#### Naming
- Follow Rails naming conventions: singular model classes, plural REST resources/controllers, and plural database tables.
- Keep Todo-related UI, JSON views, and partials under `app/views/todos/` unless the partial is reused across multiple resources.

#### Authorization
- No authorization layer exists yet.
- If authorization is added, keep app-wide checks in `ApplicationController`.
- Keep resource-specific callbacks near the top of the relevant controller, alongside existing `before_action` callbacks.
- Do not introduce `app/policies/` or a policy gem unless the feature actually needs a reusable authorization layer.

#### Controller responses
- Existing resource controllers respond to HTML and JSON.
- For successful HTML writes, redirect with a notice.
- For failed HTML writes, render the form again with `:unprocessable_content`.
- For JSON writes, render the resource on success and errors on failure.
- Do not add Turbo Stream responses unless the controller has `format.turbo_stream` handling and matching `.turbo_stream.erb` views.

#### Shared partials
- Resource-specific partials stay in that resource view folder, such as `app/views/todos/_form.html.erb`.
- Shared cross-resource partials should go in `app/views/shared/` when introduced.


### DON'Ts

- Don't introduce Node/npm, Webpack, Vite, or React unless explicitly required; this app uses importmap, Hotwire, ERB, and Propshaft.
- Don't switch the database from SQLite unless the task explicitly requires it.
- Don't add Redis for cache, jobs, or cable by default; production uses the Rails Solid stack.
- Don't add Turbo Stream responses unless matching controller handling and `.turbo_stream.erb` views are added together.
- Don't bypass strong parameters in controllers.
- Don't edit `db/schema.rb` by hand; use migrations.
- Don't commit secrets, env files, runtime files, logs, uploaded files, or SQLite database files.
- Don't introduce an authorization gem or `app/policies/` until there is a real authorization requirement.