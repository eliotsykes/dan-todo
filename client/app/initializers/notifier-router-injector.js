export function initialize(container, application) {
  // Injects router into the notifier service:
  application.inject('service:notifier', 'router', 'router:main');
}

export default {
  name: 'notifier-router-injector',
  initialize: initialize
};
