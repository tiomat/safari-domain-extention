# Architecture Documentation / Архитектура

## Обзор системы / System Overview

Domain Tracker состоит из двух основных компонентов:
1. **macOS приложение-обёртка** (Domain Tracker.app)
2. **Safari Web Extension** (встроенное расширение)

Domain Tracker consists of two main components:
1. **macOS wrapper application** (Domain Tracker.app)
2. **Safari Web Extension** (embedded extension)

```
┌─────────────────────────────────────────────┐
│          macOS Application Layer            │
│  ┌───────────────────────────────────────┐  │
│  │  Domain Tracker.app                   │  │
│  │  - AppDelegate.swift                  │  │
│  │  - ViewController.swift               │  │
│  │  - Main.storyboard (UI)               │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
                    │
                    │ Embeds
                    ▼
┌─────────────────────────────────────────────┐
│       Safari Extension (Web Extension)      │
│  ┌───────────────────────────────────────┐  │
│  │  manifest.json (configuration)        │  │
│  │                                       │  │
│  │  Background Script:                   │  │
│  │  - background.js                      │  │
│  │    • Listens to webRequest           │  │
│  │    • Stores domains per tab          │  │
│  │    • Manages tab lifecycle           │  │
│  │                                       │  │
│  │  Popup UI:                            │  │
│  │  - popup.html (structure)            │  │
│  │  - popup.js (logic)                  │  │
│  │  - popup.css (styling)               │  │
│  │                                       │  │
│  │  Native Handler:                      │  │
│  │  - SafariWebExtensionHandler.swift   │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
                    │
                    │ Communicates with
                    ▼
┌─────────────────────────────────────────────┐
│              Safari Browser                 │
│  - Web Request API                          │
│  - Tabs API                                 │
│  - Runtime Messaging                        │
└─────────────────────────────────────────────┘
```

## Поток данных / Data Flow

### 1. Отслеживание доменов / Domain Tracking

```
Webpage loads/makes request
        │
        ▼
browser.webRequest.onBeforeRequest
        │
        ▼
Extract hostname from URL
        │
        ▼
Store in Map<tabId, Set<domain>>
        │
        ▼
Domain stored for active tab
```

### 2. Отображение доменов / Domain Display

```
User clicks extension icon
        │
        ▼
popup.html loads
        │
        ▼
popup.js executes
        │
        ▼
Query active tab (browser.tabs.query)
        │
        ▼
Send message to background script
        │
        ▼
background.js returns domain list
        │
        ▼
popup.js displays domains
```

### 3. Очистка доменов / Clear Domains

```
User clicks "Clear" button
        │
        ▼
popup.js sends 'clearDomains' message
        │
        ▼
background.js clears Set for tab
        │
        ▼
popup.js reloads empty list
```

## Компоненты / Components

### Background Script (background.js)

**Ответственность / Responsibility:**
- Отслеживание всех веб-запросов
- Хранение доменов по вкладкам
- Управление жизненным циклом вкладок
- Обработка сообщений от popup

**Ключевые структуры данных / Key Data Structures:**
```javascript
tabDomains: Map<tabId: number, domains: Set<string>>
```

**API использование / API Usage:**
- `browser.webRequest.onBeforeRequest` - перехват запросов
- `browser.tabs.onRemoved` - очистка при закрытии вкладки
- `browser.tabs.onReplaced` - обработка замены вкладок
- `browser.runtime.onMessage` - коммуникация с popup

### Popup (popup.html/js/css)

**Ответственность / Responsibility:**
- Отображение списка доменов
- Взаимодействие с пользователем
- Запрос данных из background script

**UI Элементы / UI Elements:**
- Header с заголовком и кнопкой Clear
- Content area с списком доменов
- Footer с счетчиком доменов

**Состояния интерфейса / UI States:**
1. **Loading** - загрузка данных
2. **No Domains** - нет доменов для отображения
3. **Domain List** - отображение списка доменов

### macOS App (AppDelegate.swift, ViewController.swift)

**Ответственность / Responsibility:**
- Запуск и хостинг расширения
- Проверка статуса расширения
- Открытие настроек Safari

**Функциональность / Functionality:**
- Показывает статус расширения (включено/выключено)
- Кнопка для открытия настроек Safari
- Информация о расширении

## Безопасность / Security

### Разрешения / Permissions

**manifest.json permissions:**
```json
{
  "permissions": ["webRequest", "activeTab", "tabs"],
  "host_permissions": ["<all_urls>"]
}
```

**Entitlements (sandboxing):**
- App Sandbox включен
- Доступ только к выбранным файлам

### Приватность / Privacy

- ✅ Домены хранятся только в памяти
- ✅ Нет отправки данных на сервер
- ✅ Данные удаляются при закрытии вкладки
- ✅ Нет сохранения истории

## Производительность / Performance

### Оптимизации / Optimizations

1. **Set для хранения доменов** - автоматическая дедупликация
2. **Map для индексации по вкладкам** - быстрый доступ O(1)
3. **Автоматическая очистка** - предотвращение утечек памяти
4. **Ленивая загрузка popup** - загружается только при клике

### Ограничения / Limits

- Нет ограничения на количество доменов per tab
- Память очищается при закрытии вкладки
- Service Worker может быть выгружен Safari при неактивности

## Расширяемость / Extensibility

### Возможные улучшения / Possible Improvements

1. **Экспорт данных** - сохранение списка доменов в файл
2. **Фильтрация** - поиск по доменам
3. **Статистика** - подсчет запросов per domain
4. **Блокировка** - черный/белый список доменов
5. **Группировка** - по типу ресурса или домену 1-го уровня
6. **История** - сохранение истории между сессиями
7. **Уведомления** - алерты о новых доменах

### Точки расширения / Extension Points

```javascript
// background.js - добавить обработчик
browser.runtime.onMessage.addListener((message) => {
  if (message.action === 'newAction') {
    // Ваша логика
  }
});

// popup.js - добавить UI элемент
function addNewFeature() {
  // Ваша функциональность
}
```

## Отладка / Debugging

### Инструменты / Tools

1. **Safari Web Inspector**
   - Develop → Web Extension Background Pages
   - Инспектирование popup через правый клик

2. **Console Logging**
   ```javascript
   console.log('Debug info:', data);
   ```

3. **Xcode Debugger**
   - Для Swift кода (AppDelegate, ViewController)

### Типичные проблемы / Common Issues

| Проблема / Issue | Решение / Solution |
|------------------|-------------------|
| Домены не отслеживаются | Проверить permissions в manifest.json |
| Popup пустой | Проверить browser.tabs.query результат |
| Extension не загружается | Проверить код подписи в Xcode |
| Background script не работает | Проверить service worker в Web Inspector |

## API Reference

### Browser APIs Used

- **webRequest API** - `browser.webRequest.onBeforeRequest`
- **Tabs API** - `browser.tabs.query`, `browser.tabs.onRemoved`
- **Runtime API** - `browser.runtime.onMessage`, `browser.runtime.sendMessage`

### Safari-specific APIs

- **SafariServices** - `SFSafariExtensionManager`, `SFSafariApplication`

## Версионирование / Versioning

**Текущая версия / Current Version:** 1.0

**Совместимость / Compatibility:**
- macOS 10.14+
- Safari 14+
- Manifest V3
