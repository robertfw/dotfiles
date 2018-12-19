alias ls='gls -lNhFA --color=auto --group-directories-first'
alias gs='git status'
alias gb='git branch'
alias gc='git commit -m'
alias vss='vagrant ssh'

function flush_dns() {
    echo Killing mDNSResponder...
    sudo killall -HUP mDNSResponder && echo Killed!
    echo Killing mDNSResponderHelper
    sudo killall mDNSResponderHelper && echo Killed!
    echo Flushing cache...
    sudo dscacheutil -flushcache && echo Flushed!
}

function mvln() {
    mv $1 $2
    ln -s $2 $1
}

function get_kafka_broker_ids() {
	cd ~/op/fullstack/kafka-cluster
}

watch_zookeeper() {
    watch -n 1 -d "echo mntr | nc $1 2181 | grep 'server_state\|alive'"
}

watch_kafka_test_topics() {
    cd ~/op/fullstack/kafka-cluster
    watch -n 5 -d "vagrant ssh $1 -c 'sudo /srv/kafka/kafka_2.10-0.8.2.1/bin/kafka-topics.sh --describe --zookeeper localhost | grep testing.*Leader'"
}
