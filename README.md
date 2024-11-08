# Mobile iOS Case

## Proje Süresi:
Projenin tamamlanma süresi 4 gün olarak belirlenmiştir.

## Proje Amacı
Verilen dummy API ve UX tasarımlarını kullanarak, Swift ile bir grup listeleme ve seçim işlevleri içeren iOS uygulaması geliştirmek. Uygulamanın temel bileşenlerinden biri, grup seçim işlemlerini içeren ve seçimlerin bir Bottom Sheet modal view içinde gösterildiği bir ekran olacaktır.

## Fonksiyonel Gereklilikler
- Swift'in ve iOS SDK’nın en güncel sürümleri kullanılmalıdır.
- Ekran tasarımlarını temel almakla birlikte, tasarımlar üzerinde özelleştirme yapılabilir.
- Liste elemanlarına seçim özelliği eklenmeli ve yapılan seçimler, Bottom Sheet benzeri bir modal view'de gösterilmelidir.
- İsteğe bağlı olarak "Favorilere Ekle" gibi bir özellik eklenebilir; bu özellik için seçilen öğelerin UserDefaults veya KeyChain kullanılarak cihazın yerel hafızasına kaydedilmesi sağlanmalıdır.
- Network işlemleri için Alamofire kütüphanesi kullanılmalıdır.
- Farklı ekran boyutlarına uyum için AutoLayout kullanımı dikkate alınmalıdır.
- Uygulamanın stabil çalışması ve "crash-free" olması beklenmektedir.

## Ekstra Gereklilikler (Olması Güzel)
- Animasyonlar ve ekran geçişleri.
- Özel bir UIView veya SwiftUI bileşeni.
- Reactive Programming kullanımı (Örn: RxSwift).
- Dark Mode uyumluluğu.
- Türkçe ve İngilizce dil desteği (Localization).
- Unit test eklenmesi (Tam kapsamlı olması beklenmemektedir).

## Beklentiler
- **Temiz kod ve mimari**: SOLID prensiplerine uygun, açık ve okunabilir bir kod yapısı.
- **Apple Human Interface Guidelines**’a uyumlu kullanıcı arayüzü.
- Derlenebilir ve sorunsuz çalışan bir uygulama.
- Anlaşılır ve açıklayıcı yorum satırları.
- Servis ve UI katmanlarının birbirinden ayrılması; MVVM, VIPER veya MVC gibi mimariler tercih edilebilir.

## API
Uygulama için kullanılacak API:  
```
https://intertechtr.github.io/interview.json
```

## Notlar
- Servis katmanı ve diğer UI bileşenleri için üçüncü parti kütüphaneler kullanılabilir.
- Görsel tasarımlar örnek ekranlar olup, adaydan bu tasarımları kendi yaklaşımı ile iOS UI prensiplerine uygun şekilde geliştirmesi beklenmektedir.
  

  ![ios_interview](https://github.com/user-attachments/assets/478d6bd1-579d-499d-a455-30e4edfa90b1)
