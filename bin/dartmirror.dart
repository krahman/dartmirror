import 'dart:mirrors';

class MyClass{
  int i, j;
  void my_method(){}
  int sum() => i + j;
  MyClass(this.i, this.j);
  static noise() => 42;
  static var s;
}

void main() {
  
  MyClass myClass = new MyClass(3, 4);
  
  InstanceMirror im = reflect(myClass);
  ClassMirror cm = im.type;
  
  InstanceMirror res = im.invoke(#sum, []);
  print('sum = ${res.reflectee}');
  
  var f = cm.invoke(#noise, []);
  print('noise = $f');
  
  print('\nMethods: ');
  Iterable<DeclarationMirror> decls = cm.declarations.values.where(
      (dm) => dm is MethodMirror && dm.isRegularMethod
      );
  decls.forEach(
    (MethodMirror mm)
      {
        print(MirrorSystem.getName(mm.simpleName));
      }
  );
      
  print('\nDeclarations');
  for(var k in cm.declarations.keys){
    print(MirrorSystem.getName(k));
  }
  
  cm.setField(#s, 91);
  print(MyClass.s);
}
