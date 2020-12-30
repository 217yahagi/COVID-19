import cv2
import numpy as np
import matplotlib.pyplot as plt






def c_1d_to_2d(l,cols):
    return [l[i:i + cols] for i in range(0, len(l), cols)]

width=3
p_c=['01Hokkaido','02Aomori','03Iwate','04Miyagi','05Akita','06Yamagata','07Fukushima','08Ibaraki','09Tochigi','10Gunma','11Saitama','12Chiba','13Tokyo','14Kanagawa','15Niigata','16Toyama','17Ishikawa','18Fukui','19Yamanashi','20Nagano','21Gifu','22Shizuoka','23Aichi','24Mie','25Shiga','26Kyoto','27Osaka','28Hyogo','29Nara','30Wakayama','31Tottori','32Shimane','33Okayama','34Hiroshima','35Yamaguchi','36Tokushima','37Kagawa','38Ehime','39Kochi','40Fukuoka','41Saga','42Nagasaki','43Kumamoto','44Oita','45Miyazaki','46Kagoshima','47Okinawa']
p_c=p_c[36:47]
print(" "+p_c[1]+".png")

im = [cv2.imread(" "+i+" .png") for i in p_c]
print("読み込み完了")


##白画面
blank = np.zeros((im[0].shape[0], im[0].shape[1],3))
blank += 255 
cv2.imwrite('blank.png',blank)

blank=cv2.imread("blank.png")

##print(type(im),type(blank))
print(width-len(im)%width)
if len(im)%width!=0:
    for i in range(width-len(im)%width):
        im.append(blank)
##print(im)
im=cv2.vconcat([cv2.hconcat(im[i:i+width]) for i in range(0, len(im), width)])


##for i in range(0, len(im), width):
##    print(i)
##    one_line=cv2.hconcat(im[i:i+width])
##    plt.imshow(one_line)
##    plt.show()

plt.imshow(im)
plt.show()
#im=c_1d_to_2d(im,width)


cv2.imwrite('ALL4.png',im)

