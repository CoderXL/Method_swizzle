Method_swizzle
==============

##method swizzle
参考链接 <a>http://nshipster.com/method-swizzling/</a>

###1.要在+load方法中进行，而不是+initialize
###2.由于method swizzle通常（总是）运行一次，而且要考虑多线程的问题，所以需要用dispatch_once。

***

###selector，Method，Implementation的关系
**Selector**，selector用来在运行时表示一个method的名称。selector是objc runtime注册的一个c string。selector有编译器生成，并在class加载时自动完成映射。<br />
**Method**，在类定义中表示method的一个不透明类型。<br />
**Implementation**，该数据类型是个指针类型，指向实现该Method的函数。第一个参数是指向self的指针（该class实例对应的内存，对于类方法，指向的是metaclass），第二个参数是selector，后面是参数。