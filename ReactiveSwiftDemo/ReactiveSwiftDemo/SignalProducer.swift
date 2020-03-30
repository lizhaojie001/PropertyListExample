//
//  SignalProducer.swift
//  ReactiveSwiftDemo
//
//  Created by xdf_yanqing on 2019/12/25.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
extension ViewController {
    
    func signalProducerTag() {
        
        // Do any additional setup after loading the view.
        //        signalProducer()
        //        emptyProducer()
        //        neverProducer()
        //        startWithSignalFunction()
        //        startWithResult()
        //        startWithValues()
        //        startWithCompleted()
        //        startWithFailed()
        //        startWithInterrupted()
        //          lift()
        //        mapError()
        //        takeFirst()
        //        skipNil()
        //        zip()
        //         repeatValue()
        //        retry()
        //        then()
        //        replayLazily()
        //        flatMap()
        //        flatMapError()
        //        sample()
        //        logEvents()
    }
    //信号发生器 冷信号 订阅之后,重新全部发送一次 信号订阅
    func signalProducer() {
        let producer = SignalProducer<Int, Never> { observer, _ in
            print("New subscription, starting operation")
            observer.send(value: 1)
            observer.send(value: 2)
            observer.send(value: 4)
            
        }
        
        let subscriber1 = Signal<Int, Never>.Observer(value: { print("Subscriber 1 received \($0)") })
        let subscriber2 = Signal<Int, Never>.Observer(value: { print("Subscriber 2 received \($0)") })
        
        print("Subscriber 1 subscribes to producer")
        producer.start(subscriber1)
        
        print("Subscriber 2 subscribes to producer")
        // Notice, how the producer will start the work again
        producer.start(subscriber2)
        
        
    }
    
    
    //空信号 只会发送完成给订阅者
    func emptyProducer(){
        let emptyProducer = SignalProducer<Int, Never>.empty
        
        let observer = Signal<Int, Never>.Observer(
            value: { _ in print("value not called") },
            failed: { _ in print("error not called") },
            completed: { print("completed called") }
        )
        
        emptyProducer.start(observer)
    }
    
    //never 不会发送任何消息给订阅者
    
    func neverProducer() {
        let neverProducer = SignalProducer<Int, Never>.never
        
        let observer = Signal<Int, Never>.Observer(
            value: { _ in print("value not called") },
            failed: { _ in print("error not called") },
            completed: { print("completed not called") }
        )
        
        neverProducer.start(observer)
    }
    
    
    /// startWithSignal 创建一个信号,
    func startWithSignalFunction() {
        var started = false
        var value: Int?
        let subscrier = Signal<Int,Never>.Observer({ item in
            
            print(" 3 :" + "\(item.value)")
            
        })
        
        SignalProducer<Int, Never>(value: 42)
            .on(value: {
                value = $0
            })
            .startWithSignal { signal, disposable in
                print(" 2 :" + "\(value)")
                signal.observe(subscrier)
        }
        
        print(" 1 :" + "\(value)")
    }
    
    ///startWithResult 创建一个带Result的producer
    func startWithResult() {
        let dis : Disposable = SignalProducer<Int, Never>(value: 42)
            .startWithResult { result in
                print(result.value)
                
        }
        
    }
    
    func startWithValues(){
        SignalProducer<Int, Never>(value: 42)
            .startWithValues { value in
                print(value)
        }
    }
    
    func startWithCompleted()
    {
        SignalProducer<Int, Never>(value: 42)
            .startWithCompleted {
                print("completed called")
        }
    }
    
    func startWithFailed()
    {
        SignalProducer<Int, NSError>(error: NSError(domain: "example", code: 42, userInfo: nil))
            .startWithFailed { error in
                print(error)
        }
    }
    
    func startWithInterrupted() {
        let disposable = SignalProducer<Int, Never>.never
            .startWithInterrupted {
                print("interrupted called")
        }
        
        disposable.dispose()
    }
    
    
    //MARK: 对信号进行一元操作
    
    func lift(){
        var counter = 0
        let transform: (Signal<Int, Never>) -> Signal<Int, Never> = { signal in
            counter = 42
            return signal.map{ $0 + counter }
        }
        
        SignalProducer<Int, Never>(value: 12)
            .lift(transform)
            .startWithValues { value in
                print(value,counter)
        }
    }
    
    
    func map(){
        SignalProducer<Int, Never>(value: 1)
            .map { $0 + 41 }
            .startWithValues { value in
                print(value)
        }
    }
    
    public enum PlaygroundError : Error , CustomDebugStringConvertible{
        case example(String)
        public var debugDescription: String {
            switch self  {
            case .example(let str):
                return "example(" +  str + ")"
            }
        }
    }
    
    func mapError() {
        SignalProducer<Int, NSError>(error: NSError(domain: "mapError", code: 42, userInfo: nil))
            .mapError { PlaygroundError.example($0.description) }
            .startWithFailed { error in
                print(error )
        }
        
        SignalProducer<Int, NSError>(error: NSError(domain: "mapError", code: 42, userInfo: nil))
            .mapError { (error) -> PlaygroundError in
                return PlaygroundError.example("hahah")
            }.startWithFailed { error in
                debugPrint(error )
        }
    }
    ///take(first:)
    func takeFirst() {
        SignalProducer<Int, Never>([ 1, 2, 3, 4 ])
            .take(first: 2)
            .startWithValues { value in
                print(value)
        }
    }
    
    ///skipNil
    func skipNil() {
        SignalProducer<Int?, Never>([ nil, 1, 2, nil, 3, 4, nil ])
            .skipNil()
            .startWithValues { value in
                print(value)
        }
    }
    
    ///zip(with:) 对应合并
    func zip() {
        let baseProducer = SignalProducer<Int, Never>([ 1, 2, 3, 4 ])
        let zippedProducer = SignalProducer<Int, Never>([ 42, 43 ])
        
        baseProducer
            .zip(with: zippedProducer)
            .startWithValues { value in
                print("\(value)")
        }
    }
    
    ///repeat
    func repeatValue() {
        var counter = 0
        
        SignalProducer<(), Never> { observer, disposable in
            debugPrint("1" + "\(disposable)")
            counter += 1
            observer.sendCompleted()
            }
            .repeat(42)
            .startWithSignal { (signal, disposable)  in
                debugPrint("2" + "\(disposable)")
        }
        
        print(counter)
    }
    
    func retry() {
        var tries = 0
        SignalProducer<Int, NSError> { observer, disposable in
            if tries == 0 {
                tries += 1
                observer.send(error: NSError(domain: "retry", code: 0, userInfo: nil))
            } else {
                observer.send(value: 42)
                observer.sendCompleted()
            }
            }.retry(upTo: 1).startWithResult { (result) in
                print(result.value,result.error)
        }
    }
    //替换生产者转发值,如果发生错误将不会转发数据
    func then() {
        let baseProducer = SignalProducer<Int, Never>([ 1, 2, 3, 4 ])
        let thenProducer = SignalProducer<Int, Never>(value: 42)
        
        baseProducer
            .then(thenProducer)
            .startWithValues { value in
                print(value)
        }
    }
    ///replayLazily(upTo:) 创建一个SignalProducer.buffer 存储后2个数
    func replayLazily() {
        let baseProducer = SignalProducer<Int, Never>([ 1, 2, 3, 4, 42 ])
            .replayLazily(upTo: 2)
        
        baseProducer.startWithValues { value in
            print(1 , value)
        }
        
        baseProducer.startWithValues { value in
            print(2, value)
        }
        
        baseProducer.startWithValues { value in
            print(3,value)
        }
    }
    
    
    ///    flatMap(.last) 将最新的值给到创建的producer中
    func flatMap() {
        SignalProducer<Int, Never>([ 1, 2, 3, 4 ])
            .flatMap(.latest) { SignalProducer(value: $0 + 3) }
            .startWithValues { value in
                print(value)
        }
    }
    
    ///flatMapError  //发生错误替换为新建的producer处理
    func flatMapError() {
        SignalProducer<Int, NSError>(error: NSError(domain: "flatMapError", code: 42, userInfo: nil))
            .flatMapError { _ in SignalProducer<Int, Never>(value: 66) }
            .startWithValues { value in
                print(value)
        }
    }
    
    
    ///sample(with:) //取前者的最后一个值与后者元素组成元组
    func sample() {
        let producer = SignalProducer<Int, Never>([ 1, 2, 3, 4 ])
        let sampler = SignalProducer<String, Never>([ "a", "b" ])
        
        //        let result = producer.sample(with: sampler)
        let result = sampler.sample(with: producer)
        result.logEvents().startWithValues { (item) in
            print(item)
        }
        result.startWithValues { left, right in
            print("\(left) \(right)")
        }
    }
    
    ///logEvents 输出接受者收到的发送 打印声明周期
    func logEvents() {
        let baseProducer = SignalProducer<Int, Never>([ 1, 2, 3, 4, 42 ])
        
        baseProducer
            .logEvents(identifier: "Playground is fun!")
            .start()
    }
    
}
