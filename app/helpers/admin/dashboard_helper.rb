# frozen_string_literal: true

module Admin::DashboardHelper
  def feature_hint(feature, enabled)
    indicator   = safe_join([enabled ? t('simple_form.yes') : t('simple_form.no'), fa_icon('power-off fw')], ' ')
    class_names = enabled ? 'pull-right positive-hint' : 'pull-right neutral-hint'

    safe_join([feature, content_tag(:span, indicator, class: class_names)])
  end

  def relevant_account_ip(account, ip_query)
    matched_ip = begin
      ip_query_addr = IPAddr.new(ip_query)
      account.user.recent_ips.find { |(_, ip)| ip_query_addr.include?(ip) }
    rescue IPAddr::Error
      [account.user_current_sign_in_at, account.user_current_sign_in_ip]
    end

    matched_ip.last
  end
end
