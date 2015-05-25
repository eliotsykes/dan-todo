export function initialize(container, application) {
  // Injects all Ember components with a store object:
  application.inject('component', 'store', 'store:main');
}

export default {
  name: 'component-store-injector',
  initialize: initialize
};
