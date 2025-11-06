# Domain Tracker - Safari Extension

Safari расширение для отображения всех доменов, на которые текущая вкладка отправляет запросы.

Safari extension that shows all domains that the current tab sends requests to.

## Функции / Features

- 🌐 Отслеживание всех доменов, на которые отправляются запросы со страницы
- 📊 Подсчет количества уникальных доменов
- 🧹 Возможность очистить список для текущей вкладки
- 🎨 Чистый и современный интерфейс в стиле macOS
- ⚡ Легковесное и быстрое расширение

---

- 🌐 Tracks all domains that a page sends requests to
- 📊 Counts unique domains
- 🧹 Ability to clear the list for the current tab
- 🎨 Clean and modern macOS-style interface
- ⚡ Lightweight and fast extension

## Системные требования / System Requirements

- macOS 10.14 (Mojave) или новее
- Xcode 14.0 или новее
- Safari 14 или новее

## Установка и сборка / Installation and Build

### Шаг 1: Клонирование репозитория / Step 1: Clone the repository

```bash
git clone https://github.com/tiomat/safari-domain-extention.git
cd safari-domain-extention
```

### Шаг 2: Открытие проекта в Xcode / Step 2: Open the project in Xcode

```bash
open "Domain Tracker/Domain Tracker.xcodeproj"
```

### Шаг 3: Настройка подписи кода / Step 3: Configure code signing

1. Выберите проект `Domain Tracker` в Project Navigator (левая панель)
2. Выберите таргет `Domain Tracker` в списке таргетов
3. Перейдите на вкладку "Signing & Capabilities"
4. Выберите вашу Team в выпадающем списке "Team"
5. Повторите шаги 2-4 для таргета `Domain Tracker Extension`

**Примечание:** Если у вас нет Apple Developer аккаунта, вы можете использовать свой Apple ID. Xcode автоматически создаст бесплатный профиль разработчика.

---

1. Select the `Domain Tracker` project in Project Navigator (left panel)
2. Select the `Domain Tracker` target from the target list
3. Go to the "Signing & Capabilities" tab
4. Select your Team from the "Team" dropdown
5. Repeat steps 2-4 for the `Domain Tracker Extension` target

**Note:** If you don't have an Apple Developer account, you can use your Apple ID. Xcode will automatically create a free developer profile.

### Шаг 4: Изменение Bundle Identifier (опционально) / Step 4: Change Bundle Identifier (optional)

Если возникают конфликты с Bundle Identifier:

1. В настройках таргета `Domain Tracker`, во вкладке "General"
2. Измените "Bundle Identifier" с `com.example.Domain-Tracker` на что-то уникальное (например, `com.yourname.Domain-Tracker`)
3. Повторите для таргета `Domain Tracker Extension`, изменив на `com.yourname.Domain-Tracker.Extension`

---

If there are Bundle Identifier conflicts:

1. In the `Domain Tracker` target settings, on the "General" tab
2. Change "Bundle Identifier" from `com.example.Domain-Tracker` to something unique (e.g., `com.yourname.Domain-Tracker`)
3. Repeat for the `Domain Tracker Extension` target, changing to `com.yourname.Domain-Tracker.Extension`

### Шаг 5: Сборка проекта / Step 5: Build the project

1. Выберите схему `Domain Tracker` в верхней панели Xcode
2. Выберите "My Mac" в качестве устройства
3. Нажмите ⌘+B (Command+B) или выберите Product → Build
4. После успешной сборки нажмите ⌘+R (Command+R) или выберите Product → Run

Приложение `Domain Tracker` запустится автоматически.

---

1. Select the `Domain Tracker` scheme in the top bar of Xcode
2. Select "My Mac" as the device
3. Press ⌘+B (Command+B) or select Product → Build
4. After a successful build, press ⌘+R (Command+R) or select Product → Run

The `Domain Tracker` app will launch automatically.

### Шаг 6: Включение расширения в Safari / Step 6: Enable the extension in Safari

1. Запустите приложение `Domain Tracker` (если еще не запущено)
2. Нажмите кнопку "Open Safari Preferences" в приложении, или откройте Safari → Settings → Extensions
3. Найдите "Domain Tracker" в списке расширений
4. Установите флажок, чтобы включить расширение
5. Нажмите "Turn On" в диалоговом окне, если потребуется

**Важно:** После первой установки может потребоваться перезапуск Safari.

---

1. Launch the `Domain Tracker` app (if not already running)
2. Click "Open Safari Preferences" button in the app, or open Safari → Settings → Extensions
3. Find "Domain Tracker" in the extensions list
4. Check the checkbox to enable the extension
5. Click "Turn On" in the dialog if prompted

**Important:** You may need to restart Safari after the first installation.

## Использование / Usage

1. Откройте любую веб-страницу в Safari
2. Кликните на иконку расширения Domain Tracker в панели инструментов Safari (иконка глобуса)
3. В всплывающем окне вы увидите список всех доменов, на которые страница отправила запросы
4. Используйте кнопку "Clear" для очистки списка текущей вкладки
5. Счетчик внизу показывает общее количество отслеженных доменов

---

1. Open any webpage in Safari
2. Click the Domain Tracker extension icon in the Safari toolbar (globe icon)
3. In the popup, you'll see a list of all domains the page sent requests to
4. Use the "Clear" button to clear the list for the current tab
5. The counter at the bottom shows the total number of tracked domains

## Структура проекта / Project Structure

```
safari-domain-extention/
├── Domain Tracker/
│   ├── Domain Tracker.xcodeproj/    # Xcode project file
│   ├── Shared (App)/                # macOS app files
│   │   ├── AppDelegate.swift        # App delegate
│   │   ├── ViewController.swift     # Main window controller
│   │   ├── Main.storyboard          # UI layout
│   │   ├── Assets.xcassets/         # App icons
│   │   └── Domain_Tracker.entitlements
│   └── Domain Tracker Extension/    # Safari extension files
│       ├── manifest.json            # Extension manifest
│       ├── background.js            # Background script (domain tracking)
│       ├── popup.html               # Popup UI
│       ├── popup.js                 # Popup logic
│       ├── popup.css                # Popup styles
│       ├── images/                  # Extension icons
│       ├── SafariWebExtensionHandler.swift
│       ├── Info.plist
│       └── Domain_Tracker_Extension.entitlements
├── README.md
└── LICENSE
```

## Разработка / Development

### Как это работает / How it works

1. **background.js** - Фоновый скрипт, который слушает все веб-запросы через API `browser.webRequest.onBeforeRequest`. Он извлекает домены из URL и сохраняет их в Map, где ключом является ID вкладки.

2. **popup.html/js/css** - Интерфейс всплывающего окна, которое показывается при клике на иконку расширения. Запрашивает данные из фонового скрипта и отображает список доменов.

3. **SafariWebExtensionHandler.swift** - Swift-обработчик для коммуникации между расширением и нативным приложением (в данной версии используется минимально).

---

1. **background.js** - Background script that listens to all web requests via the `browser.webRequest.onBeforeRequest` API. It extracts domains from URLs and stores them in a Map where the key is the tab ID.

2. **popup.html/js/css** - Popup interface shown when clicking the extension icon. Requests data from the background script and displays the domain list.

3. **SafariWebExtensionHandler.swift** - Swift handler for communication between the extension and native app (minimally used in this version).

### Debugging

Для отладки расширения:

1. Откройте Safari → Develop → Web Extension Background Pages → Domain Tracker
2. Или кликните правой кнопкой на popup и выберите "Inspect Element"

---

To debug the extension:

1. Open Safari → Develop → Web Extension Background Pages → Domain Tracker
2. Or right-click on the popup and select "Inspect Element"

## Решение проблем / Troubleshooting

### Расширение не отображается в Safari

1. Убедитесь, что приложение Domain Tracker запущено хотя бы один раз
2. Перезапустите Safari
3. Проверьте Safari → Settings → Extensions

### Домены не отслеживаются

1. Убедитесь, что расширение включено в настройках Safari
2. Проверьте, что у расширения есть разрешения для текущего сайта
3. Обновите страницу, чтобы начать отслеживание

### Ошибки сборки в Xcode

1. Убедитесь, что выбрана правильная Team в настройках подписи кода
2. Попробуйте очистить проект (Product → Clean Build Folder)
3. Проверьте, что используется Xcode 14.0 или новее

---

### Extension doesn't show in Safari

1. Make sure the Domain Tracker app has been launched at least once
2. Restart Safari
3. Check Safari → Settings → Extensions

### Domains are not being tracked

1. Make sure the extension is enabled in Safari settings
2. Check that the extension has permissions for the current site
3. Refresh the page to start tracking

### Xcode build errors

1. Make sure the correct Team is selected in code signing settings
2. Try cleaning the project (Product → Clean Build Folder)
3. Verify you're using Xcode 14.0 or newer

## Лицензия / License

MIT License - see LICENSE file for details
