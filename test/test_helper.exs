:application.start :inets

test_server_config = [
  port: 9090,
  server_name: 'hound_test_server',
  server_root: Path.absname('test/sample_pages'),
  document_root: Path.absname('test/sample_pages'),
  bind_address: {127,0,0,1}
]
{:ok, pid} = :inets.start(:httpd, test_server_config)

{:ok, _hound_pid} = Hound.start([driver: System.get_env("WEBDRIVER")])

System.at_exit fn(_exit_status) ->
  :ok = :inets.stop(:httpd, pid)
end

ExUnit.start [max_cases: 5]
