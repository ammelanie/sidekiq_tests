# How to

To run this script, you will need `sidekiq` gem. 

Run `sidekiq` using `sidekiq -r ./test_worker.rb` you can add `-c` parameter to determine the `concurrency` 

Then run a console with the `test_worker.rb` script. The entry point of this script should be the `RunWorkerService` it will launch as many `perform_async` as you want on the selected worker. 
So, if you run `RunWorkerService.run('SimpleWorker', 10)` this will trigger 10 times the `SimpleWorker`.

The `SimpleWorker` just puts a line like this one : 

``` 
[8341][70336667605020][2018-09-20T14:21:13.484842+02:00][SimpleWorker][perform]
```

with [`Process.pid`][`Thread.current.object_id`][`Time`][`SimpleWorker`][`method`]

The `MultiThreadWorker` can be called to. This worker will create some threads inside a two level loop will performing and will output same data as the `SimpleWorker`. 