//
//  ViewController.m
//  FloatView
//
//  Created by Eric on 2017/3/21.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "QLFloatLayoutView.h"

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#import <SystemConfiguration/SystemConfiguration.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
//#import "UIDevice-Reachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
//#import "UIDevice-Reachability.h"

@interface ViewController () <QLFloatLayoutViewDelegate, QLFloatLayoutViewDataSource>

@end

@implementation ViewController

+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

- (void)clickbe{
    __block int i = 100000;
    while (i > 0) {
        dispatch_async(dispatch_queue_create("qranalytics.main", DISPATCH_QUEUE_SERIAL), ^{
//            sleep(0.5);
            [[self class] getIPAddress:YES];
            i--;
        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 80, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(clickbe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return;
    
    QLFloatLayoutView *floatView = [[QLFloatLayoutView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height  * 0.5)];
//    floatView.padding = UIEdgeInsetsMake(20, 10, 20, 10);
    floatView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    floatView.maximumItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 200, CGFLOAT_MAX);
//    floatView.horizonAlign = YES;
    [self.view addSubview:floatView];
    
    floatView.delegate = self;
    floatView.dataSource = self;
    [floatView reloadData];
}

- (NSString *)makeRandomTitleWithIndex:(NSUInteger) index
{
    NSString *result = @"";
    NSUInteger max =  random() % 20;;
    for (NSUInteger i = 0; i < max; i++) {
        result = [NSString stringWithFormat:@"%@發", result];
    }
    result = [NSString stringWithFormat:@"%@+%lu", result, index];
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - delegate
-(void)floatLayoutView:(QLFloatLayoutView *)floatLayoutView didSelectItemViewAtIndex:(NSUInteger)index
{
    NSLog(@"%lu", index);
}


#pragma mark - datasource
- (NSInteger)numberOfItemsForFloatLayoutView:(QLFloatLayoutView *)floatLayoutView
{
    return 20;
}

-(UIView *)floatLayoutView:(QLFloatLayoutView *)floatLayoutView itemViewForIndex:(NSUInteger)index
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.text = [self makeRandomTitleWithIndex:index];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:button.titleLabel.text];
    [titleString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, [titleString length])];
    [button setAttributedTitle: titleString forState:UIControlStateNormal];
    return button;
}

@end
