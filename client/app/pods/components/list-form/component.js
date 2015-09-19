import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    delete() {
      let cancelled = !window.confirm("Are you sure you want to delete this list?");
      if (cancelled) {
        return;
      }

      let list = this.get('list');

      let transitionToListIndex = () => {
        this.get('router').transitionTo(
          'list.index', { queryParams: { editsLocked: true } }
        );
      };

      let notifier = this.get('notifier');
      let successMessage = "List deleted.";

      function onSuccess() {
        notifier.setMessage(successMessage);
        transitionToListIndex();
      }

      list.destroyRecord().then(onSuccess);
    },
    // save() is called when form is submitted
    save() {
      let list = this.get('list');

      // Use ES6 arrow function => syntax to avoid having to call .bind(this)
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions
      let transitionToListIndex = () => {
        this.get('router').transitionTo(
          'list.index', { queryParams: { editsLocked: true } }
        );
      };

      let hasUnsavedChanges = list.get('isDirty');

      if (!hasUnsavedChanges) {
        transitionToListIndex();
        return;
      }

      // Get the notifier service:
      let notifier = this.get('notifier');
      let successMessage = this.get('successMessage');
      let errorMessage = this.get('errorMessage');

      function onSuccess() {
        notifier.setMessage(successMessage);
        transitionToListIndex();
      }

      function onFailure(error) {
        let errors = error.responseJSON.errors;
        if (Ember.isPresent(errors)) {
          errorMessage += " " + errors.join(". ");
        }
        notifier.setMessage(errorMessage);
      }

      // Register/save the list via an AJAX request to the server API:
      list.save().then(onSuccess).catch(onFailure);
    }
  }

});
