# Set public path to be the Ember-managed client/dist directory:
Rails.application.config.paths["public"] = File.join("client", "dist")