import Vue from 'vue'

new Vue({
  el: "#header-upload",
  data: {
    dataHeader: '',
  },
  methods: {
    setHeader(e) {
      const files = e.target.files;
      if (files.length > 0) {
        const file = files[0];
        const reader = new FileReader();
        reader.onload = (e) => {
          this.dataHeader = e.target.result;
        };
        reader.readAsDataURL(file);
      }
    }
  }
});
