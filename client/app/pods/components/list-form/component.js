import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    delete() {
      let cancelled = !window.confirm("Are you sure you want to delete this list?");

      if (cancelled) {
        return;
      }

      let list = this.get('list');
      let notifier = this.get('notifier');
      let successMessage = "List deleted.";

      let onSuccess = () => {
        notifier.setMessage(successMessage);
        this.transitionToListIndex();
      }

      list.destroyRecord().then(onSuccess);
    },
    // save() is called when form is submitted
    save() {
      let list = this.get('list');
      let hasUnsavedChanges = list.get('isDirty');

      if (!hasUnsavedChanges) {
        this.transitionToListIndex();
        return;
      }

      // Get the notifier service:
      let notifier = this.get('notifier');
      let successMessage = this.get('successMessage');
      let errorMessage = this.get('errorMessage');

      let onSuccess = () => {
        notifier.setMessage(successMessage);
        this.transitionToListIndex();
      }

      let onFailure = (error) => {
        let errors = error.responseJSON.errors;
        if (Ember.isPresent(errors)) {
          errorMessage += " " + errors.join(". ");
        }
        notifier.setMessage(errorMessage);
      }

      // Register/save the list via an AJAX request to the server API:
      list.save().then(onSuccess).catch(onFailure);
    }
  },
  transitionToListIndex() {
    this.get('router').transitionTo(
      'list.index', { queryParams: { editsLocked: true } }
    );
  }

});
