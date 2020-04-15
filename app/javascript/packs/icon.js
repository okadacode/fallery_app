import Vue from 'vue'

new Vue({
  el: "#icon-upload",
  data: {
    dataIcon: '',
  },
  methods: {
    setIcon(e) {
      const files = e.target.files;
      if (files.length > 0) {
        const file = files[0];
        const reader = new FileReader();
        reader.onload = (e) => {
          this.dataIcon = e.target.result;
        };
        reader.readAsDataURL(file);
      }
    }
  }
});
