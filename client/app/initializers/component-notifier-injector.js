export function initialize(_container, application) {
  // Injects all Ember components with a notifier object:
  application.inject('component', 'notifier', 'service:notifier');
}

export default {
  name: 'component-notifier-injector',
  initialize: initialize
};
