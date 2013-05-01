//
//  SectionABC.m
//  练习tableview
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SectionABC.h"
#import "String.h"
#import "pinyin.h"

@implementation SectionABC
+(NSMutableArray *)zhongWenPaiXu:(NSMutableArray *)newArray
{
    
//    NSLog(@"[[[[%@",[newArray objectAtIndex:1]);;
//    NSMutableDictionary *dictDict=[NSMutableDictionary dictionary]; //可变的字典
    NSMutableArray *chineseStringsArray=[NSMutableArray array];  //初始化一个可变数组
     for(int i=0;i<[newArray count];i++)
    {    
       String *chineseString=[[String alloc]init];        
         chineseString.string=[NSString stringWithString:[newArray objectAtIndex:i]]; //取出数组里的对象调用他的属性sname  赋给新创建的类 String的对象chineseString的属性string
        
        NSLog(@"===%@",chineseString.string);
        if(chineseString.string==nil)
        {    
           chineseString.string=@"";     //对象chineseString的属性string为空
        }                    
       if(![chineseString.string isEqualToString:@""])
        {    //对象chineseString的属性string不为空
            NSString *pinYinResult=[NSString string];      //初始化一个字符串对象 开辟空间
            NSLog(@"--------------%@",chineseString.string);
            for(int j=0;j<chineseString.string.length;j++){     
                 NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];    // 用pinyinFirstLetter（）自定义函数把  chineseString.string 字符串转化为拼音字符 再取出第一大小字母  赋给一个新字符串singlePinyinLetter
                
                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];  //把存有字母大小的字符串存到一个可变的字符串pinYinResult里          
            }              
            
            chineseString.pinYin=pinYinResult; //把存有可变的首字母大写的字符串 赋给 String类 chineseString对象的属性 pinYin
            
        }else{
            
            chineseString.pinYin=@"";      //String类 chineseString对象的属性 pinYin属性为空
            
        }          
        
        [chineseStringsArray addObject:chineseString];  //在把整个对象chineseString添加到 可变数组里
        
    }  
    //存的所有名字的首字母  有重复的
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];   
    [chineseStringsArray sortUsingDescriptors:sortDescriptors]; 

    //取出首字母 存到集合中 去除相同的字母 集合的特性
    NSMutableSet *set=[NSMutableSet set];
    for(int i=0;i<[chineseStringsArray count];i++){         
        String *chineseString=[chineseStringsArray objectAtIndex:i];    
        NSString *temps=[chineseString.pinYin substringToIndex:1];
        NSLog(@"%@",temps);
        [set addObject:temps];
    }   
    
    //取出集合中的所有对象存入可变的数组中
    NSMutableArray *tempArray2=[NSMutableArray arrayWithArray:[set allObjects]];
    NSLog(@"%@",tempArray2);
    
//    for (int m=0; m<[tempArray2 count]; m++) 
//    {
//        NSMutableArray *arrayLast=[[NSMutableArray alloc]init];
//        
//        for (int k=0; k<[chineseStringsArray count]; k++) {
//            
//            String  *chineseString=[chineseStringsArray objectAtIndex:k];//取出存有的所有对象 
//            
//            NSString *temps=[chineseString.pinYin substringToIndex:1]; //取除所有的拼音首字母
//            
//            if ([[tempArray2 objectAtIndex:m]isEqualToString:temps]) 
//            {
////                NSLog(@"%@=--==-=%@",[tempArray2 objectAtIndex:m],temps);
//                [arrayLast addObject:chineseString.string];//把符合添加的对象存添加到数组中 
//                [dictDict setValue:arrayLast forKey:temps]; //存入到字典中
//            }
//        }
//
//    }
    
    NSArray *tempArray3=[tempArray2 sortedArrayUsingSelector:@selector(compare:)]; //数组排序
    NSMutableArray *tempArray4=[NSMutableArray arrayWithArray:tempArray3];

    for(int i=0;i<[tempArray3 count];i++){    
          
                NSLog(@"%@",[tempArray3 objectAtIndex:i]);   
                
        }                //程序结束    
            
   return tempArray4;
    
    
}
@end
