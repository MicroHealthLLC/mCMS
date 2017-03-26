//= require rordit/vue/vue.min.js
//= require rordit/vue/vue-resource.min.js
//= require rordit/index.js

window.addEventListener("load", function () {
    Vue.component('modal', {
        template: '#modal-template'
    });

    var emailRE = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    var app = new Vue({
        el: '#vue-app',
        mixins: [myMixin],
        data: {
            modalMessage: "",
            showingModal: false
        },
        computed: {
            validateEmail: function () {
                return {
                    warning: !emailRE.test(this.email) && this.email.length > 0
                }
            },
            validatePassword: function () {
                return {
                    warning: this.password.length > 0 && this.password.length < 6
                }
            },
            validateSubmit: function () {
                return {
                    disabled: this.validatePassword["warning"] || this.validateEmail["warning"]
                    || this.email.length == 0 || this.password.length == 0
                }
            }
        },
        methods: {
            showModal: function (message) {
                this.modalMessage = message;
                this.showingModal = true;
            }
        }
    });
});
