# دليل نشر موقعك أونلاين مجاناً 100% مدى الحياة 🚀
(Permanent & 100% Free Hosting Guide)

أهلاً يا فارس! مش محتاج تشتري أي دومين نهائياً، ومش محتاج دومينات مؤقتة تتعبك في التجديد كل شوية.
المبرمجين المحترفين بيستخدموا منصات مجانية مدى الحياة بتديك:
- **دومين مجاني دائم** باسمك (مبيخلصش أبداً).
- **شهادة أمان مجانية (HTTPS / SSL)**.
- **سيرفرات سريعة جداً CDN حول العالم**.

---

## الخيار الأول (الأفضل والموصى به): GitHub Pages 🌟
بما إن عندك حساب على GitHub ومشاريعك عليه، ده أفضل خيار لأن اللينك هيكون احترافي جداً:
`https://FaresFady.github.io/portfolio/`

### الخطوات (مرة واحدة بس وبعد كدا أي تعديل بيترفع لوحده):
1. **افتح حسابك على GitHub** وأنشئ مستودع جديد (New Repository) سمه مثلاً: `portfolio`.
2. ارفع كود المشروع عليه من الـ Terminal:
   ```bash
   git init
   git add .
   git commit -m "Initial commit of Flutter portfolio"
   git branch -M main
   git remote add origin https://github.com/FaresFady/portfolio.git
   git push -u origin main
   ```
3. **فعل الـ GitHub Pages**:
   - ادخل على الـ Repo في GitHub -> اضغط على **Settings**.
   - من القائمة الجانبية اضغط على **Pages**.
   - تحت قسم **Build and deployment**:
     - في **Source** اختار: **GitHub Actions**.
4. **مبروك!** احنا مجهزينلك ملف `.github/workflows/deploy.yml` أوتوماتيك:
   - أول ما تعمل `git push`، جيت هاب هيعمل `flutter build web` وينشر الموقع في دقيقة واحدة.
   - اللينك بتاعك هيكون: `https://FaresFady.github.io/portfolio/`

---

## الخيار الثاني (الأسهل والأسرع بدون أي أوامر): Vercel ⚡
Vercel بتديك لينك سريع جداً مجاني مدى الحياة مثل: `https://fares-portfolio.vercel.app`

### الخطوات:
1. ادخل على موقع [Vercel.com](https://vercel.com) وسجل دخول بحسابك في GitHub.
2. اضغط **Add New Project**.
3. اختار الـ Repository بتاعك (`portfolio`).
4. في إعدادات الـ Build:
   - **Build Command**: `flutter/bin/flutter build web --release` (أو ببساطة ارفع مجلد `build/web`).
5. أو أسهل طريقة لـ Vercel بدون جيت هاب:
   - نزّل Vercel CLI في الـ terminal: `npm i -g vercel`
   - ادخل مجلد `build/web` واكتب أمر: `vercel --prod`
   - هيديك لينك شغال فوراً!

---

## الخيار الثالث: Firebase Hosting (خدمة جوجل الرسمية) 🔥
منصة جوجل الرسمية وتكامل ممتاز مع Flutter:
`https://fares-elhabashy.web.app`

### الخطوات:
1. افتح [Firebase Console](https://console.firebase.google.com/) وأنشئ مشروع جديد.
2. في الـ Terminal:
   ```bash
   npm install -g firebase-tools
   firebase login
   firebase init hosting
   ```
   - اختار الـ Project بتاعك.
   - لما يسألك: `What do you want to use as your public directory?` اكتب: `build/web`
   - لما يسألك: `Configure as a single-page app?` اكتب: `Yes`
3. لما تبني المشروع:
   ```bash
   flutter build web --release
   firebase deploy --only hosting
   ```
   وهيكون موقعك متاح أونلاين على `https://fares-elhabashy.web.app` مجاناً مدى الحياة!

---

## ملخص سريع
- **أفضل شكل للـ CV**: `https://FaresFady.github.io/portfolio` (لأن شركات التوظيف بتحب تشوف مبرمج مستخدم GitHub).
- **التكلفة**: **0$ (صفر جنيه مدى الحياة)**.
- **التجديد**: **لا يحتاج أي تجديد نهائياً**.
