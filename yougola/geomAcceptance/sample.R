library(readxl)
library(openxlsx)

df <- read_csv("C:/Users/igola/Desktop/igola/geom/hotel/agoda_china_full_output_processed.csv")
df_1 <- df %>%
  filter(距离分类<= 1) 
#热门酒店
##订单热门
df_ref <- read_xls("C:/Users/igola/Desktop/igola/geom/hotel/ref/2018-04-01_2018-05-31hotel_order_report.xls")
df_ref <- df_ref %>%
  filter(str_detect(df_ref$城市名字, "中国$")) %>%
  group_by(酒店ID) %>%
  mutate(count = n()) %>%
  ungroup() %>%
  select(城市名字, 酒店中文名, 酒店英文名, count) %>%
  distinct() %>%
  arrange(desc(count)) 
df_ref$城市名字 <- str_remove(df_ref$城市名字, ',.*')
df_ref <- df_ref %>%
  filter(count >= 2) %>%
  select(-count)
names(df_ref) <- c("中文城市", "中文名", "英文名")
##推
df_ref2 <- read.xlsx("C:/Users/igola/Desktop/igola/geom/hotel/ref/推.xlsx")
df_reff <- rbind(df_ref,df_ref2)
#全眼
a <- df_1 %>%
  filter (df_1$中文名 %in% df_reff$中文名)
b <- df_1 %>%
  filter (df_1$英文名 %in% df_reff$英文名)
heat <- union(a,b)
write.xlsx(heat,"C:/Users/igola/Desktop/igola/geom/hotel/ref/样本/全验.xlsx" )
#热门城市
df_rest_1 <- setdiff(df_1,heat) 
df_top20 <- df_rest_1 %>% 
  filter(str_detect(df_rest_1$中文城市,'广州|上海|北京|深圳|成都|三亚|西安|杭州|重庆|厦门|青岛|苏州|昆明|大连|丽江|江门|大理|天津|珠海|长沙'))
  
getsample <- function(N,error,P,Z){
  n = ((1.96^2)*N*(1-P)*P)/((N-1)*(error^2)*(P^2)+(1.96^2)*P*(1-P))
  return(ceiling(n))
}
n <- getsample(N= nrow(df_top20), error = 0.05, P = 0.95)
sample_city <- df_top20[sample(nrow(df_top20), n), ]
write.xlsx(sample_city,"C:/Users/igola/Desktop/igola/geom/hotel/ref/样本/样本_热门城市.xlsx" )
#rest
df_rest_2 <- setdiff(df_rest_1,df_top20) 
n2 <- getsample(N= nrow(df_rest_2), error = 0.1, P = 0.9)
sample_rest <- df_rest_2[sample(nrow(df_rest_2), n2), ]
write.xlsx(sample_rest,"C:/Users/igola/Desktop/igola/geom/hotel/ref/样本/样本_剩余城市.xlsx" )

