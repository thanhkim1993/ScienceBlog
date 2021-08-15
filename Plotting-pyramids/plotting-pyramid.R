
### Các package cần
library(ggplot2) # Vẽ hình
library(patchwork) # Kết nối các hình với nhau

### Tải file mẫu phân theo nhóm tuổi
linkURL <- "https://raw.githubusercontent.com/thanhkim1993/blog/main/Weighted-Population.csv"  # Lưu đường link
temporary <- tempfile(pattern = "Weighted-Population", fileext = ".csv") # Tạo một đường dẫn tạm thời trong máy tính
download.file(linkURL, temporary, method = "curl") # Tải file csv theo đường dẫn tạm thời
population <- read.csv(temporary) # Import file vào R
unlink(temporary) # Xóa đường dẫn. Lưu ý bước này cần phải làm để tránh ứ đọng file trong máy tính

### Vẽ tháp tuổi trong nghiên cứu CHIME
# Bước 1: Khai báo data set và trục tọa độ cho ggplot2
figure1 <- ggplot(population, aes(x = age_g5, y = population, fill = male_u))



figure1 <- ggplot(population, aes(x = age_g5, y = ifelse(male_u == "Male", -population/1000,population/1000), fill = male_u)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_y_continuous(labels = abs, limits = max(population$population/1000)*c(-1,1)) +
  scale_fill_manual(name="Sex",
                    breaks=c("Female", "Male"),
                    values = c("blue","red")) + labs(x = "Age group", y = "Population (thousand)") +
  labs(title = "Weighted population pyramid in CHIME")  + theme_bw()

linkURL <- "https://raw.githubusercontent.com/thanhkim1993/blog/main/HCMC-population.csv"
temporary <- tempfile(pattern = "HCMC-Population", fileext = ".csv")
download.file(linkURL, temporary, method = "curl")
HCMCpopulation <- read.csv(temporary)
unlink(temporary)


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
