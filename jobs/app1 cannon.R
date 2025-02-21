devtools::load_all()
cmd = load_test_command(url = 8001L, output_dir = 'run_app1w5', workers = 10, loaded_duration = 4, log_file = 'app1')
cmd
system(command = cmd)
