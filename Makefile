.PHONY: all build test clean

all: build test

build:
	mkdir -p tmp/opt/prometheus/exporters/hadoop
	go build -o tmp/opt/prometheus/exporters/hadoop/prometheus-hadoop-namenode -i namenode_exporter.go  
	go build -o tmp/opt/prometheus/exporters/hadoop/prometheus-hadoop-resourcemanager -i resourcemanager_exporter.go  
	fpm -s dir -t rpm -n prometheus-hadoop-exporters --directories /opt/prometheus/exporters/hadoop --rpm-init etc/prometheus-hadoop-exporters  -p ./ -C tmp/

clean:
	rm -Rf tmp
	rm ./*.rpm
test:
	go test
