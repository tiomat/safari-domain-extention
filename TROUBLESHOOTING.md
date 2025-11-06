# Troubleshooting Guide / Руководство по устранению неполадок

## Проблемы со сборкой / Build Issues

### ❌ "No signing identity found"

**Проблема:** Xcode не может найти сертификат для подписи кода.

**Решение:**
1. Откройте Xcode → Preferences → Accounts
2. Добавьте ваш Apple ID (если не добавлен)
3. Выберите проект → Target → Signing & Capabilities
4. В поле "Team" выберите ваш Apple ID
5. Xcode автоматически создаст Development Certificate

---

**Problem:** Xcode can't find a code signing certificate.

**Solution:**
1. Open Xcode → Preferences → Accounts
2. Add your Apple ID (if not added)
3. Select project → Target → Signing & Capabilities
4. In "Team" field, select your Apple ID
5. Xcode will automatically create a Development Certificate

### ❌ "Bundle identifier conflict"

**Проблема:** Bundle ID уже используется.

**Решение:**
1. Выберите Target "Domain Tracker"
2. General → Identity → Bundle Identifier
3. Измените `com.example.Domain-Tracker` на `com.yourname.Domain-Tracker`
4. Повторите для "Domain Tracker Extension" → `com.yourname.Domain-Tracker.Extension`

---

**Problem:** Bundle ID is already in use.

**Solution:**
1. Select "Domain Tracker" target
2. General → Identity → Bundle Identifier
3. Change `com.example.Domain-Tracker` to `com.yourname.Domain-Tracker`
4. Repeat for "Domain Tracker Extension" → `com.yourname.Domain-Tracker.Extension`

### ❌ "Command PhaseScriptExecution failed"

**Проблема:** Ошибка при выполнении build script.

**Решение:**
1. Product → Clean Build Folder (⇧⌘K)
2. Закройте и откройте Xcode заново
3. Попробуйте собрать снова

---

**Problem:** Build script execution error.

**Solution:**
1. Product → Clean Build Folder (⇧⌘K)
2. Close and reopen Xcode
3. Try building again

## Проблемы с расширением / Extension Issues

### ❌ Расширение не отображается в Safari / Extension doesn't show in Safari

**Диагностика / Diagnosis:**
```bash
# Проверьте, установлено ли приложение
ls -la ~/Library/Developer/Xcode/DerivedData/Domain*/Build/Products/Debug/

# Проверьте расширения Safari
defaults read com.apple.Safari.Extensions
```

**Решение / Solution:**
1. ✅ Убедитесь, что приложение Domain Tracker запускалось хотя бы один раз
2. ✅ Перезапустите Safari полностью (Safari → Quit Safari)
3. ✅ Откройте Safari → Settings → Extensions
4. ✅ Найдите "Domain Tracker" и включите его
5. ✅ Если не видно, попробуйте пересобрать в Xcode

### ❌ "Extension is damaged" / "Расширение повреждено"

**Проблема:** macOS блокирует неподписанное расширение.

**Решение:**
1. Убедитесь, что код подписан правильно в Xcode
2. Для разработки используйте Development certificate
3. Для распространения нужен Apple Developer Program ($99/год)

**Временное решение (только для разработки):**
```bash
# Снять карантин с приложения (используйте с осторожностью!)
xattr -d com.apple.quarantine "/path/to/Domain Tracker.app"
```

---

**Problem:** macOS blocks unsigned extension.

**Solution:**
1. Ensure code is signed correctly in Xcode
2. For development, use Development certificate
3. For distribution, Apple Developer Program is required ($99/year)

**Temporary workaround (development only):**
```bash
# Remove quarantine flag (use with caution!)
xattr -d com.apple.quarantine "/path/to/Domain Tracker.app"
```

### ❌ Домены не отслеживаются / Domains not being tracked

**Проверка / Check:**

1. **Расширение включено?**
   - Safari → Settings → Extensions → Domain Tracker ✓

2. **Есть ли разрешения?**
   - В popup расширения должна быть возможность кликнуть

3. **Background script работает?**
   ```
   Safari → Develop → Web Extension Background Pages → Domain Tracker
   Проверьте console на ошибки
   ```

4. **Попробуйте другой сайт:**
   - Некоторые сайты могут блокировать отслеживание
   - Попробуйте простой сайт типа example.com

---

**Check:**

1. **Extension enabled?**
   - Safari → Settings → Extensions → Domain Tracker ✓

2. **Has permissions?**
   - Extension popup should be clickable

3. **Background script running?**
   ```
   Safari → Develop → Web Extension Background Pages → Domain Tracker
   Check console for errors
   ```

4. **Try another site:**
   - Some sites may block tracking
   - Try a simple site like example.com

### ❌ Popup пустой или не работает / Popup empty or not working

**Диагностика / Diagnosis:**

1. Откройте popup
2. Правый клик → Inspect Element
3. Проверьте Console на ошибки

**Типичные ошибки / Common errors:**

```javascript
// Ошибка: "Cannot read property 'id' of undefined"
// Причина: browser.tabs.query вернул пустой массив
// Решение: Убедитесь, что активна какая-то вкладка

// Ошибка: "Error: Could not establish connection"
// Причина: Background script не отвечает
// Решение: Перезапустите Safari
```

### ❌ "Developer mode is required"

**Safari 17+:** Нужно включить Developer Mode

**Решение / Solution:**
1. Safari → Settings → Advanced
2. Включите "Show Develop menu in menu bar"
3. Develop → Allow Unsigned Extensions
4. Перезапустите Safari

## Проблемы с разрешениями / Permission Issues

### ❌ "Extension needs permission to read and alter webpages"

Это нормальное поведение Safari для расширений с host_permissions.

**Что делать:**
1. Нажмите "Allow" для сайтов, которые хотите отслеживать
2. Или: "Always Allow" для постоянного доступа

---

This is normal behavior for extensions with host_permissions.

**What to do:**
1. Click "Allow" for sites you want to track
2. Or: "Always Allow" for permanent access

### ❌ Расширение работает только на некоторых сайтах

**Проблема:** Некоторые сайты имеют особые ограничения.

**Ограничения Safari:**
- Локальные файлы (file://)
- Страницы Safari (safari://)
- Некоторые системные страницы

**Решение:** Это нормально и ограничено браузером.

---

**Problem:** Some sites have special restrictions.

**Safari limitations:**
- Local files (file://)
- Safari pages (safari://)
- Some system pages

**Solution:** This is normal and limited by the browser.

## Проблемы с производительностью / Performance Issues

### ❌ Safari тормозит с расширением / Safari slows down with extension

**Возможные причины:**
1. Слишком много доменов в памяти
2. Memory leak

**Решение:**
1. Нажмите "Clear" в popup для очистки
2. Закройте неиспользуемые вкладки
3. Перезапустите Safari

**Профилирование / Profiling:**
```
Safari → Develop → Web Extension Background Pages → Domain Tracker
→ Timeline → Start Recording
```

---

**Possible causes:**
1. Too many domains in memory
2. Memory leak

**Solution:**
1. Click "Clear" in popup to reset
2. Close unused tabs
3. Restart Safari

**Profiling:**
```
Safari → Develop → Web Extension Background Pages → Domain Tracker
→ Timeline → Start Recording
```

## Логи и отладка / Logging and Debugging

### Включить подробное логирование / Enable verbose logging

**В background.js добавьте:**
```javascript
const DEBUG = true;

function log(...args) {
  if (DEBUG) console.log('[Domain Tracker]', ...args);
}

// Используйте вместо console.log
log('Tracked domain:', domain);
```

### Просмотр логов расширения / View extension logs

1. **Background Script:**
   ```
   Safari → Develop → Web Extension Background Pages → Domain Tracker
   ```

2. **Popup:**
   ```
   Правый клик на popup → Inspect Element → Console
   ```

3. **macOS App:**
   ```
   Запустите из Xcode (⌘R) и смотрите Xcode console
   ```

## Переустановка / Reinstallation

### Полная переустановка / Complete reinstall

```bash
# 1. Удалите приложение
rm -rf ~/Library/Developer/Xcode/DerivedData/Domain*

# 2. Очистите Safari extensions
# Safari → Settings → Extensions → удалите Domain Tracker

# 3. Пересоберите в Xcode
# Product → Clean Build Folder (⇧⌘K)
# Product → Build (⌘B)
# Product → Run (⌘R)

# 4. Перезапустите Safari
killall Safari

# 5. Включите расширение снова
```

## Получение помощи / Getting Help

Если проблема не решена:

1. **Проверьте Issues на GitHub:**
   https://github.com/tiomat/safari-domain-extention/issues

2. **Создайте новый Issue с информацией:**
   - Версия macOS
   - Версия Safari
   - Версия Xcode
   - Полный текст ошибки
   - Скриншоты (если применимо)

3. **Логи:**
   - Console output из Safari Web Inspector
   - Build logs из Xcode (если ошибка сборки)

---

If the problem persists:

1. **Check GitHub Issues:**
   https://github.com/tiomat/safari-domain-extention/issues

2. **Create new Issue with information:**
   - macOS version
   - Safari version
   - Xcode version
   - Full error text
   - Screenshots (if applicable)

3. **Logs:**
   - Console output from Safari Web Inspector
   - Build logs from Xcode (if build error)

## Полезные команды / Useful Commands

```bash
# Проверить установленные расширения Safari
defaults read com.apple.Safari.Extensions

# Найти логи Safari
log show --predicate 'subsystem == "com.apple.Safari"' --last 1h

# Проверить сертификаты подписи
codesign -dv --verbose=4 "Domain Tracker.app"

# Список всех Safari processes
ps aux | grep Safari

# Убить все процессы Safari (осторожно!)
killall Safari
```
