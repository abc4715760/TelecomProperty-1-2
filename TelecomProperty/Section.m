//
//  Section.m
//  练习tableview
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Section.h"
#import "String.h"

#import "pinyin.h"
#import "Zhongwenpaixu.h"
@implementation Section
+(NSMutableDictionary *)SectionZiMu:(NSMutableArray *)newArray
{   NSMutableDictionary *dictDict=[[NSMutableDictionary alloc]init];
    NSMutableArray *chineseStringsArray=[NSMutableArray array];  //初始化一个可变数组
    
    for(int i=0;i<[newArray count];i++){    
        
        String *chineseString=[[String alloc]init];        
        
        chineseString.string=[NSString stringWithString:[newArray objectAtIndex:i]]; //取出数组里的对象调用他的属性sname  赋给新创建的类 String的对象chineseString的属性string   
        
        if(chineseString.string==nil){    
            
            chineseString.string=@"";     //对象chineseString的属性string为空
            
        }                    
        
        if(![chineseString.string isEqualToString:@""]){    //对象chineseString的属性string不为空
            
            NSString *pinYinResult=[NSString string];      //初始化一个字符串对象 开辟空间
            
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
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];   
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];  

    //Step2输出     
    

    
    NSMutableSet *set=[NSMutableSet set];
    for(int i=0;i<[chineseStringsArray count];i++){         
        String *chineseString=[chineseStringsArray objectAtIndex:i];    
        NSString *temps=[chineseString.pinYin substringToIndex:1];
        NSLog(@"%@",temps);
        [set addObject:temps];
    }   
    NSMutableArray *tempArray2=[NSMutableArray arrayWithArray:[set allObjects]];
    NSLog(@"%@",tempArray2);
    for (int m=0; m<[tempArray2 count]; m++) {
        NSMutableArray *arrayLast=[[NSMutableArray alloc]init];
        for (int k=0; k<[chineseStringsArray count]; k++) {
            String  *chineseString=[chineseStringsArray objectAtIndex:k];
            NSString *temps=[chineseString.pinYin substringToIndex:1];
              if ([[tempArray2 objectAtIndex:m]isEqualToString:temps]) {
                [arrayLast addObject:chineseString.string];
                [dictDict setValue:arrayLast forKey:temps];
            }
       }
   
    }
 
    return dictDict;
    
    
}
@end
