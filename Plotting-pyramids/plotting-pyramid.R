
### Các package c???n
library(ggplot2) # V??? hình
library(patchwork) # K???t n???i các hình v???i nhau

### T???i d??? li???u theo nhóm tu???i trong nghiên c???u CHIME
linkURL <- "https://raw.githubusercontent.com/thanhkim1993/ScienceBlog/main/Plotting-pyramids/Weighted-Population.csv"  # Luu du???ng link
temporary <- tempfile(pattern = "Weighted-Population", fileext = ".csv") # T???o m???t du???ng d???n t???m th???i trong máy tính
download.file(linkURL, temporary, method = "curl") # T???i t???p tin csv v??? máy theo du???ng d???n t???m th???i
population <- read.csv(temporary) # Import t???p tin csv vào R
unlink(temporary) # Xóa t???p tin csv và du???ng d???n tuong ???ng. Dây là bu???c c???n thi???t d??? tránh ??? d???ng file không c???n thi???t

### V??? tháp tu???i trong nghiên c???u CHIME
# Bu???c 1: Khai báo data set và tr???c t???a d??? cho ggplot2. Lúc này ch??? th???y tr???c t???a d???. Chua có hình.
ggplot(population, aes(x = age_g5, y = population, fill = male_u))  # l???nh `fill = male_u` nh???m phân t???ng theo gi???i tính

# Bu???c 2: V??? bi???u d??? c???t
ggplot(population, aes(x = age_g5, y = population, fill = male_u)) +  # Luu ý ??? dây có d???u c???ng. Xu???ng hàng cho nó g???n.
  geom_bar(stat = "identity") # `geom_bar(stat = "identity")`` ch???c nang y h???t `geom_bar()``

# Bu???c 3: Tách bi???t nam và n??? b???ng m???t tr???c cho gi???ng tháp tu???i
ggplot(population, aes(x = age_g5, y = ifelse(male_u == "Male", -population,population), fill = male_u)) +
  geom_bar(stat = "identity") 

# Bu???c 4: V??? bi???u d??? n???m ngang cho gi???ng tháp tu???i
ggplot(population, aes(x = age_g5, y = ifelse(male_u == "Male", -population,population), fill = male_u)) +
  geom_bar(stat = "identity") +
  coord_flip() # L???nh này giúp xoay hình n???m ngang

# Bu???c 5: Format l???i thông tin trên tr???c x,y và ch???nh màu s???c cho d???p, r???i gán vào `chart1`
chart1 <- ggplot(population, aes(x = age_g5, y = ifelse(male_u == "Male", -population/1000,population/1000), fill = male_u)) + 
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_fill_manual(name = "Sex",   # D???t tên legend
                    breaks = c("Female", "Male"),
                    values = c("blue","red")) + #Ch???nh màu
  scale_y_continuous(labels = abs, # tr??? truy???t d???i c???t y
                     limits = max(population$population/1000)*c(-1,1)) + # Ch???nh gi???i h???n c???t y cho 2 bên d???u nhau
  labs(title = "Weighted popoulation pyramid in CHIME", x = "Age group", y = "Population (thousand)") +
  theme_bw() # Ch???nh theme màu này cho sáng hình
print(chart1)

### Tuong t??? nhu v???y, ta v??? tháp tu???i c???a Thành ph??? H??? CHí Minh trong nam 2019
### T???i d??? li???u TPHCM v??? t??? GitHub
linkURL <- "https://raw.githubusercontent.com/thanhkim1993/ScienceBlog/main/Plotting-pyramids/HCMC-population.csv"
temporary <- tempfile(pattern = "HCMC-Population", fileext = ".csv")
download.file(linkURL, temporary, method = "curl")
HCMCpopulation <- read.csv(temporary)
unlink(temporary)

### V??? tháp tu???i TPHCM r???i gán vào chart2
chart2 <- ggplot(HCMCpopulation, 
                         aes(x=Age_group, 
                             y = ifelse(sex == "Female", population/1000, -population/1000), 
                             fill = sex)) +
  geom_col() + coord_flip() +
  scale_y_continuous(labels = abs, limits = max(HCMCpopulation$population)*c(-0.001,0.001)) +
  scale_fill_manual(name="Sex",
                    breaks=c("Female", "Male"),
                    values = c("blue","red")) + labs(x = "Age group", y = "Population (thousand)")  +
  labs(title = "Population pyramid in Ho Chi MInh City")  + theme_bw()

print(chart2)


### Bây gi??? ta g???p 2 tháp tu???i v???i nhau d??? d??? so sánh. Lúc này package `patchwork` phát huy tác d???ng
appended.chart <- chart1 + chart2
print(appended.chart)

