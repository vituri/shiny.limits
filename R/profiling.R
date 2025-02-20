profile_app = function(app_function) {
  profvis::profvis({
    app_function()
  })
}


\() {
  profile_app(run_app1)
}

