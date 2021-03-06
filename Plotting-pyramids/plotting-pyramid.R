
### C�c package c???n
library(ggplot2) # V??? h�nh
library(patchwork) # K???t n???i c�c h�nh v???i nhau

### T???i d??? li???u theo nh�m tu???i trong nghi�n c???u CHIME
linkURL <- "https://raw.githubusercontent.com/thanhkim1993/ScienceBlog/main/Plotting-pyramids/Weighted-Population.csv"  # Luu du???ng link
temporary <- tempfile(pattern = "Weighted-Population", fileext = ".csv") # T???o m???t du???ng d???n t???m th???i trong m�y t�nh
download.file(linkURL, temporary, method = "curl") # T???i t???p tin csv v??? m�y theo du???ng d???n t???m th???i
population <- read.csv(temporary) # Import t???p tin csv v�o R
unlink(temporary) # X�a t???p tin csv v� du???ng d???n tuong ???ng. D�y l� bu???c c???n thi???t d??? tr�nh ??? d???ng file kh�ng c???n thi???t

### V??? th�p tu???i trong nghi�n c???u CHIME
# Bu???c 1: Khai b�o data set v� tr???c t???a d??? cho ggplot2. L�c n�y ch??? th???y tr???c t???a d???. Chua c� h�nh.
ggplot(population, aes(x = age_g5, y = population, fill = male_u))  # l???nh `fill = male_u` nh???m ph�n t???ng theo gi???i t�nh

# Bu???c 2: V??? bi???u d??? c???t
ggplot(population, aes(x = age_g5, y = population, fill = male_u)) +  # Luu � ??? d�y c� d???u c???ng. Xu???ng h�ng cho n� g???n.
  geom_bar(stat = "identity") # `geom_bar(stat = "identity")`` ch???c nang y h???t `geom_bar()``

# Bu???c 3: T�ch bi???t nam v� n??? b???ng m???t tr???c cho gi???ng th�p tu???i
ggplot(population, aes(x = age_g5, y = ifelse(male_u == "Male", -population,population), fill = male_u)) +
  geom_bar(stat = "identity") 

# Bu???c 4: V??? bi???u d??? n???m ngang cho gi???ng th�p tu???i
ggplot(population, aes(x = age_g5, y = ifelse(male_u == "Male", -population,population), fill = male_u)) +
  geom_bar(stat = "identity") +
  coord_flip() # L???nh n�y gi�p xoay h�nh n???m ngang

# Bu???c 5: Format l???i th�ng tin tr�n tr???c x,y v� ch???nh m�u s???c cho d???p, r???i g�n v�o `chart1`
chart1 <- ggplot(population, aes(x = age_g5, y = ifelse(male_u == "Male", -population/1000,population/1000), fill = male_u)) + 
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_fill_manual(name = "Sex",   # D???t t�n legend
                    breaks = c("Female", "Male"),
                    values = c("blue","red")) + #Ch???nh m�u
  scale_y_continuous(labels = abs, # tr??? truy???t d???i c???t y
                     limits = max(population$population/1000)*c(-1,1)) + # Ch???nh gi???i h???n c???t y cho 2 b�n d???u nhau
  labs(title = "Weighted popoulation pyramid in CHIME", x = "Age group", y = "Population (thousand)") +
  theme_bw() # Ch???nh theme m�u n�y cho s�ng h�nh
print(chart1)

### Tuong t??? nhu v???y, ta v??? th�p tu???i c???a Th�nh ph??? H??? CH� Minh trong nam 2019
### T???i d??? li???u TPHCM v??? t??? GitHub
linkURL <- "https://raw.githubusercontent.com/thanhkim1993/ScienceBlog/main/Plotting-pyramids/HCMC-population.csv"
temporary <- tempfile(pattern = "HCMC-Population", fileext = ".csv")
download.file(linkURL, temporary, method = "curl")
HCMCpopulation <- read.csv(temporary)
unlink(temporary)

### V??? th�p tu???i TPHCM r???i g�n v�o chart2
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


### B�y gi??? ta g???p 2 th�p tu???i v???i nhau d??? d??? so s�nh. L�c n�y package `patchwork` ph�t huy t�c d???ng
appended.chart <- chart1 + chart2
print(appended.chart)

