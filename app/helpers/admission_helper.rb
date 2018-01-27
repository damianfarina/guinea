module AdmissionHelper
  def admission_petitioner_link(admission, opts = {})
    tag_name = :a
    tag_name = :span if admission.veterinarian.blank? && admission.veterinary.blank?
    opts[:href] = veterinary_path(admission.veterinary) if admission.veterinary.present?
    opts[:href] = veterinarian_path(admission.veterinarian) if admission.veterinarian.present?
    tag.send(tag_name, opts) do
      admission.petitioner_name
    end
  end
end
