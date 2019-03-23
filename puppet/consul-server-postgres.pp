# 2019-03-22 (cc) <paul4hough@gmail.com>
#


include maul::consul::server
include maul::exporter::node

class { 'postgresql::server' : }
include maul::exporter::postgres
