# 2019-02-09 (cc) <paul4hough@gmail.com>
#

ensure_packages(['firewalld'])

include 'maul::consul'
include 'maul::prometheus'
include 'maul::alertmanager'
include 'maul::agate'
include 'maul::cat'
include 'maul::grafana'
include 'maul::exporter::consul'
include 'maul::exporter::node'
include 'maul::exporter::blackbox'
include 'maul::exporter::postgres'
# include 'maul::exporter::mule'
# include 'maul::exporter::tomcat'
# include 'maul::exporter::gemfire'
