require 'sidekiq'

class MultiThreadWorker
  include Sidekiq::Worker

  def perform(iter)
    puts "\e[32m[#{Process.pid.to_s}][\e[1;32m#{Thread.current.object_id}\e[0m\e[32m][#{Time.now.iso8601(6)}][MultiThreadWorker][perform\e[0m]"
    MakeStuffService.new(iter).do
  end
end

class MakeStuffService
  def initialize(iter)
    @iter = iter
    @threads = []
  end

  def do
    1.upto(2) do |o|
      puts "\e[31m[#{Process.pid.to_s}][\e[1;31m#{Thread.current.object_id}\e[0m\e[31m][#{Time.now.iso8601(6)}][MakeStuffService][do]         iter: #{@iter}   o: #{o}\e[0m"
      1.upto(3) do |d|
        puts "\e[34m[#{Process.pid.to_s}][\e[1;34m#{Thread.current.object_id}\e[0m\e[34m][#{Time.now.iso8601(6)}][MakeStuffService][do]         iter: #{@iter}   o: #{o}   d: #{d}\e[0m"
        @threads << ThreadingService.thread_it(@iter, o, d)
      end
    end
    @threads.each(&:join)
  end
end

class ThreadingService
  def self.thread_it(iter, o, d)
    Thread.new do
      puts "\e[33m[#{Process.pid.to_s}][\e[1;33m#{Thread.current.object_id}\e[0m\e[33m][#{Time.now.iso8601(6)}][ThreadingService][thread_it]  iter: #{iter}   o: #{o}   d: #{d}\e[0m"
    end
  end
end

class SimpleWorker
  include Sidekiq::Worker
  def perform(iter)
    puts "\e[32m[#{Process.pid.to_s}][\e[1;32m#{Thread.current.object_id}\e[0m\e[32m][#{Time.now.iso8601(6)}][SimpleWorker][perform\e[0m]"
  end
end

class RunWorkerService
  def self.run(klass, times)
    1.upto(times) do |iter|
      Object.const_get(klass).perform_async iter
    end
  end
end