#include "pico/stdlib.h"

int main(int, char**) {
  const uint led_pin = PICO_DEFAULT_LED_PIN;
  gpio_init(led_pin);
  gpio_set_dir(led_pin, GPIO_OUT);

  int led_state = 0;
  for (;;) {
    led_state = 1 - led_state;
    gpio_put(led_pin, led_state);
    sleep_ms(500);
  }

  return 0;
}
