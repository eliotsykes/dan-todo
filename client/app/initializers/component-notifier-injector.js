export function initialize(container, application) {
  // Injects all Ember components with the notifier service:
  application.inject('component', 'notifier', 'service:notifier');
}

export default {
  name: 'component-notifier-injector',
  initialize: initialize
};
