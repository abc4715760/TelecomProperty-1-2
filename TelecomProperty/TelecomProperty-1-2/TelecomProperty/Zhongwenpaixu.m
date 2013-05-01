//
//  Zhongwenpaixu.m
//  练习tableview
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Zhongwenpaixu.h"
#import "String.h"
#import "pinyin.h"

@implementation Zhongwenpaixu
+(NSMutableArray *)zhongWenPaiXu:(NSMutableArray *)newArray{

NSMutableArray *chineseStringsArray=[NSMutableArray array];  //初始化一个可变数组

for(int i=0;i<[newArray count];i++){    
    
  String *chineseString=[[String alloc]init];        
//    chineseString.string=[NSString stringWithString:[[newArray objectAtIndex:i]objectForKey:@"screen_name"]]; //取出数组里的对象调用他的属性sname  赋给新创建的类 String的对象chineseString的属性string
     chineseString.string=[NSString stringWithString:[newArray objectAtIndex:i]];
     NSLog(@"%@====",chineseString.string);
    if(chineseString.string==nil)
    {    
        chineseString.string=@"";     //对象chineseString的属性string为空
      }                    
      if(![chineseString.string isEqualToString:@""]){    //对象chineseString的属性string不为空
          NSString *pinYinResult=[NSString string];      //初始化一个字符串对象 开辟空间
          for(int j=0;j<chineseString.string.length;j++){     
            
            NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];    // 用pinyinFirstLetter（）自定义函数把  chineseString.string 字符串转化为拼音字符 再取出第一大小字母  赋给一个新字符串singlePinyinLetter
            
            pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];  //把存有字母大小的字符串存到一个可变的字符串pinYinResult里          
        }              
        
        chineseString.pinYin=pinYinResult; //把存有可变的首字母大写的字符串 赋给 String类 chineseString对象的属性 pinYin
        
    }
    else{            
        
        chineseString.pinYin=@"";      //String类 chineseString对象的属性 pinYin属性为空
        
    }          
    
    [chineseStringsArray addObject:chineseString];  //在把整个对象chineseString添加到 可变数组里
//    NSLog(@"+++++++%@",chineseStringsArray);
}              
//Step2输出     

//    NSLog(@"\n\n\n转换为拼音首字母后的NSString数组");      

//for(int i=0;i<[chineseStringsArray count];i++){      
//    
//    String *chineseString=[chineseStringsArray objectAtIndex:i];   //把数组里的每一个元素 赋给String类型的chineseString   
//    
//  //  NSLog(@"原String:%@----拼音首字母String:%@",chineseString.string,chineseString.pinYin);   //分别打印出来对象的两个 属性.string  .pinYin
//}                    
//
////Step3:按照拼音首字母对这些Strings进行排序   
    //

NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]]; //先定义一个数组按拼音排 升序   

[chineseStringsArray sortUsingDescriptors:sortDescriptors];  //排序数组本身 遵循数组sortDescriptors排序方法
////Step4输出     
//
////    NSLog(@"\n\n\n按照拼音首字母后的NSString数组");    
//
//for(int i=0;i<[chineseStringsArray count];i++){         
//    
//    String *chineseString=[chineseStringsArray objectAtIndex:i];    
//    
//    NSLog(@"原String:%@----拼音首字母String:%@",chineseString.string,chineseString.pinYin);        }              
    // Step4:如果有需要，再把排序好的内容从ChineseString类中提取出来    
    //
//    NSMutableArray *result=[NSMutableArray array];   
//    //
//    for(int i=0;i<[chineseStringsArray count];i++){      
//        //    
//        [result addObject:((String*)[chineseStringsArray objectAtIndex:i]).string];      
//    }         
//    //
//    ////Step5输出
//    //
//    //NSLog(@"\n\n\n最终结果:");    
//    //
//    for(int i=0;i<[result count];i++){    
//        //    
//        NSLog(@"%@",[result objectAtIndex:i]);   
//        
//    }                //程序结束    
//    
return chineseStringsArray;
}

@end
