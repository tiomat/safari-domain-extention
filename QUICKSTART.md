# Quick Start Guide / Краткое руководство

## Для пользователей / For Users

### Быстрая установка / Quick Installation

1. **Скачайте проект / Download the project:**
   ```bash
   git clone https://github.com/tiomat/safari-domain-extention.git
   cd safari-domain-extention
   ```

2. **Откройте в Xcode / Open in Xcode:**
   ```bash
   open "Domain Tracker/Domain Tracker.xcodeproj"
   ```

3. **Настройте подпись / Setup signing:**
   - В Xcode выберите проект `Domain Tracker`
   - Для обоих таргетов (`Domain Tracker` и `Domain Tracker Extension`):
     - Signing & Capabilities → Team → выберите ваш Apple ID
   
4. **Соберите и запустите / Build and run:**
   - Нажмите ⌘+R или кликните на кнопку Run
   - Приложение откроется автоматически

5. **Включите в Safari / Enable in Safari:**
   - Кликните "Open Safari Preferences" в приложении
   - Или: Safari → Settings → Extensions
   - Включите "Domain Tracker"

6. **Используйте / Use it:**
   - Откройте любой сайт в Safari
   - Кликните на иконку Domain Tracker в панели инструментов
   - Смотрите список всех доменов!

## Для разработчиков / For Developers

### Структура кода / Code Structure

```
Domain Tracker Extension/
├── manifest.json          # Конфигурация расширения / Extension config
├── background.js          # Отслеживание запросов / Request tracking
├── popup.html/js/css      # UI всплывающего окна / Popup UI
└── images/                # Иконки / Icons
```

### Ключевые компоненты / Key Components

**background.js:**
- Слушает все веб-запросы через `browser.webRequest.onBeforeRequest`
- Сохраняет домены в Map по ID вкладки
- Автоматически очищает данные при закрытии вкладки

**popup.js:**
- Запрашивает текущую активную вкладку
- Получает список доменов из background script
- Отображает домены в отсортированном виде

### Кастомизация / Customization

**Изменить иконку / Change icon:**
```bash
# Отредактируйте icon.svg, затем создайте PNG:
cd "Domain Tracker/Domain Tracker Extension/images"
rsvg-convert -w 128 -h 128 icon.svg -o icon-128.png
# Повторите для других размеров
```

**Изменить стиль popup / Change popup style:**
```css
/* Редактируйте popup.css */
.domain-item {
  /* Ваши стили здесь / Your styles here */
}
```

**Добавить функциональность / Add functionality:**
```javascript
// В background.js добавьте новый обработчик:
browser.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.action === 'yourNewAction') {
    // Ваш код / Your code
  }
});
```

### Отладка / Debugging

**Console лог / Console log:**
```javascript
// В background.js:
console.log('Tracking domain:', domain);

// Смотрите в Safari → Develop → Web Extension Background Pages
```

**Inspect popup:**
- Правый клик на popup → Inspect Element
- Используйте Safari Developer Tools

### Тестирование / Testing

1. Откройте сайт с множеством запросов (например, news website)
2. Кликните на иконку расширения
3. Проверьте, что отображаются все домены
4. Нажмите "Clear" и убедитесь, что список очищен
5. Обновите страницу и проверьте, что домены снова появились

## Частые вопросы / FAQ

**Q: Почему некоторые домены не отображаются?**
A: Убедитесь, что расширение имеет разрешения для сайта. Некоторые запросы могут быть заблокированы браузером.

**Q: Can I export the domain list?**
A: Currently not implemented, but you can add this feature by modifying popup.js to create a download link.

**Q: Работает ли на iOS?**
A: Нет, это расширение только для macOS Safari.

**Q: Does it track private/incognito browsing?**
A: Extension permissions may vary in private browsing mode. Check Safari settings.

## Полезные ссылки / Useful Links

- [Safari Extensions Documentation](https://developer.apple.com/documentation/safariservices/safari_web_extensions)
- [WebExtensions API](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions)
- [Safari Web Inspector Guide](https://webkit.org/web-inspector/)
