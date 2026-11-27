# APT-DEBIAN-Os-up-Date-System

**A one-command Bash script that updates, repairs, upgrades, and cleans Debian/Ubuntu (APT) systems, with Flatpak support and a persistent log.**

![Shell: Bash](https://img.shields.io/badge/shell-Bash-4EAA25?logo=gnubash&logoColor=white)
![Platform: Debian / Ubuntu (APT)](https://img.shields.io/badge/platform-Debian%20%2F%20Ubuntu%20(APT)-A81D33?logo=debian&logoColor=white)
![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-blue)

[English](#english) | [العربية](#arabic)

---

<a id="english"></a>

## English

### Overview

`update.sh` automates routine package maintenance on Debian-based systems that use APT (Debian, Ubuntu, and their derivatives). It runs the usual update, repair, upgrade, and cleanup commands in a fixed order, prints colored progress messages, and appends everything it prints to a log file so you can review past runs.

The script runs non-interactively (`DEBIAN_FRONTEND=noninteractive`) and stops at the first step that fails, with a red error message naming that step.

### What it does

1. **Checks for root.** If not run as root, it prints `This script must be run as root (try: sudo ./update.sh)` and exits before doing anything else.
2. **Starts logging.** All output from this point on is shown on screen and appended to `/var/log/update-script.log`.
3. **Updates package lists:** `apt-get update`.
4. **Lists available upgrades:** `apt list --upgradable`, or prints "No upgrades available".
5. **Repairs broken packages:** `apt-get install -f -y`, so the upgrade can run.
6. **Upgrades installed packages:** `apt-get upgrade -y`.
7. **Removes unused packages:** `apt-get autoremove -y`.
8. **Cleans the package cache:** `apt-get autoclean` (removes obsolete downloaded package files).
9. **Updates Flatpak apps:** `flatpak update -y`, only if Flatpak is installed; otherwise prints "Flatpak not installed, skipping".
10. **Prints a completion message** with the date and time.

### Requirements

- A Debian-based Linux distribution that uses APT (e.g. Debian, Ubuntu)
- Bash
- Root privileges (`sudo`)
- Flatpak (optional; the Flatpak step is skipped when it is not installed)

### Installation

```bash
git clone https://github.com/fahad4x4/APT-DEBIAN-Os-up-Date-System.git
cd APT-DEBIAN-Os-up-Date-System
chmod +x update.sh
```

### Usage

Run the script as root:

```bash
sudo ./update.sh
```

Review the log of previous runs:

```bash
sudo less /var/log/update-script.log
```

> **Note:** The script uses `apt-get upgrade`, not `full-upgrade` / `dist-upgrade`, so upgrades that require removing installed packages are not applied.

### Project structure

```
APT-DEBIAN-Os-up-Date-System/
├── update.sh    # The update and maintenance script
├── README.md    # This file
└── LICENSE      # Apache License 2.0
```

### License

This project is licensed under the [Apache License 2.0](LICENSE).

### Author

**Fahad ALGhathbar**, GitHub: [@fahad4x4](https://github.com/fahad4x4)

---

<a id="arabic"></a>

## العربية

<div dir="rtl">

### نظرة عامة

يُؤتمت السكربت `update.sh` مهام صيانة الحزم الدورية على الأنظمة المبنية على دبيان التي تستخدم مدير الحزم APT (مثل Debian وUbuntu والتوزيعات المشتقة منهما). ينفّذ أوامر التحديث والإصلاح والترقية والتنظيف المعتادة بترتيب ثابت، ويعرض رسائل تقدّم ملوّنة، ويُلحق كل ما يطبعه بملف سجل لتتمكن من مراجعة عمليات التشغيل السابقة.

يعمل السكربت دون تفاعل (`DEBIAN_FRONTEND=noninteractive`)، ويتوقف عند أول خطوة تفشل مع رسالة خطأ باللون الأحمر تحدد تلك الخطوة.

### ماذا يفعل

1. **التحقق من صلاحيات الجذر (root):** إذا لم يُشغَّل بصلاحيات الجذر، يطبع رسالة تطلب تشغيله عبر `sudo ./update.sh` ثم يخرج قبل تنفيذ أي شيء آخر.
2. **بدء التسجيل:** تُعرض جميع المخرجات بعد هذه النقطة على الشاشة وتُضاف إلى الملف `/var/log/update-script.log`.
3. **تحديث قوائم الحزم:** `apt-get update`.
4. **عرض الترقيات المتاحة:** `apt list --upgradable`، أو طباعة رسالة بعدم وجود ترقيات.
5. **إصلاح الحزم المعطوبة:** `apt-get install -f -y` حتى تتمكن الترقية من العمل.
6. **ترقية الحزم المثبتة:** `apt-get upgrade -y`.
7. **إزالة الحزم غير المستخدمة:** `apt-get autoremove -y`.
8. **تنظيف ذاكرة الحزم المؤقتة:** `apt-get autoclean` (يحذف ملفات الحزم المنزّلة التي لم تعد صالحة).
9. **تحديث تطبيقات Flatpak:** `flatpak update -y`، فقط إذا كان Flatpak مثبتًا؛ وإلا يطبع رسالة بتخطّي هذه الخطوة.
10. **طباعة رسالة اكتمال** مع التاريخ والوقت.

### المتطلبات

- توزيعة لينكس مبنية على دبيان تستخدم APT (مثل Debian أو Ubuntu)
- Bash
- صلاحيات الجذر (`sudo`)
- Flatpak (اختياري؛ تُتخطّى خطوة Flatpak إذا لم يكن مثبتًا)

### التثبيت

```bash
git clone https://github.com/fahad4x4/APT-DEBIAN-Os-up-Date-System.git
cd APT-DEBIAN-Os-up-Date-System
chmod +x update.sh
```

### الاستخدام

شغّل السكربت بصلاحيات الجذر:

```bash
sudo ./update.sh
```

لمراجعة سجل عمليات التشغيل السابقة:

```bash
sudo less /var/log/update-script.log
```

> **ملاحظة:** يستخدم السكربت الأمر `apt-get upgrade` وليس `full-upgrade` أو `dist-upgrade`، لذا لا تُطبَّق الترقيات التي تتطلب إزالة حزم مثبتة.

### هيكل المشروع

```
APT-DEBIAN-Os-up-Date-System/
├── update.sh    # سكربت التحديث والصيانة
├── README.md    # هذا الملف
└── LICENSE      # رخصة Apache 2.0
```

### الرخصة

هذا المشروع مرخّص بموجب [رخصة Apache 2.0](LICENSE).

### المؤلف

**فهد الغثبر (Fahad ALGhathbar)**، على GitHub: [@fahad4x4](https://github.com/fahad4x4)

</div>
